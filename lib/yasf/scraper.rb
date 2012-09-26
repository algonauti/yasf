require "nokogiri"

module Yasf
  class Scraper

    class << self

      def extract_from(source, options = nil)
        self.new(source, options).extract
      end

      # Defines a processing rule.
      def scrape(*args)
        name = args.shift if args.first.is_a?(Symbol)
        if args.last.is_a?(Hash)
          extractor = extractor(args.pop)
        end
        raise ArgumentError, "Missing extractor: the last argument tells us what to extract" unless extractor
        raise ArgumentError, "Missing selector: the first argument tells us what to select" if args.empty?
        define_method :__extractor, extractor
        method = instance_method(:__extractor)
        remove_method :__extractor
        rules << [args.pop, method, name]
      end

      # Returns an array of scraper rules
      def rules()
        @rules ||= []
      end

      def result(*symbols)
        raise ArgumentError, "one symbol to return the value of this accessor" if symbols.empty?
        symbols = symbols.map {|s| s.to_sym}
        if symbols.size == 1
          define_method :result do
            return self.send(symbols[0])
          end
        else
          struct = Struct.new(*symbols)
          define_method :result do
            return struct.new(*symbols.collect {|s| self.send(s) })
          end
        end
      end

      # Creates an extractor that will extract values from the selected
      # element and place them in instance variables of the scraper.
      def extractor(map)
        extracts = []
        map.each_pair do |target, source|
          source = extract_value_from(source)
          target = extract_value_to(target)
          define_method :__extractor do |element|
            value = source.call(element)
            target.call(self, value) unless value.nil?
          end
          extracts << instance_method(:__extractor)
          remove_method :__extractor
        end
        lambda do |element|
          extracts.each do |extract|
            extract.bind(self).call(element)
          end
          true
        end
      end

      private

      # Returns a Proc that will extract a value from an element.
      def extract_value_from(source)
        case source
        when Class
          unless source.ancestors.include?(Yasf::Scraper)
            raise ArgumentError, "Class must extends Yasf::Scraper"
          end
          return lambda { |element| source.new(element).extract }
        when Symbol
          return lambda do |element|
            if element.respond_to?(source)
              element.send(source)
            elsif element.respond_to?("[]", source)
              element.send("[]", source)
            else
              raise ArgumentError, "Method not found"
            end
          end
        end
      end

      # Returns a Proc that will set the extract value in the object.
      def extract_value_to(target)
        target = target.to_s
        if target[-2..-1] == "[]" or (@arrays && array = @arrays.include?(target.to_sym))
          target = target[0...-2] unless array
          # Create an attribute accessor is not already defined.
          begin
            self.instance_method(target)
          rescue NameError
            attr_accessor target
          end
          reader = "#{target}".to_sym
          writer = "#{target}=".to_sym
          return lambda do |object, value|
            array = object.send(reader)
            object.send(writer, array = []) unless array
            array << value
          end
        else
          # Create an attribute accessor is not already defined.
          begin
            self.instance_method(target)
          rescue NameError
            instance = "@#{target}".to_sym
            attr_accessor target
          end
          reader = "#{target}=".to_sym
          return lambda { |object, value| object.send(reader, value) }
        end
      end

    end # end self

    # The argument +source+ is a String (url format), or Nokogiri::XML::Element
    def initialize(source, options = nil)
      @options = options || {}
      case source
      when String
        @document = Nokogiri::HTML(open(source))
      when Nokogiri::XML::Element
        @document = source
      else
        raise ArgumentError, "source not recognized"
      end
    end

    # Returns the document being processed.
    def document
      @document
    end

    # Scrapes the document and returns the result.
    def extract
      rules = self.class.rules.clone
      rules.delete_if do |selector, extractor, rule_name|
        document.search(selector).each do |element|
          extractor.bind(self).call(element)
        end
      end
      return result
    end

  end
end
