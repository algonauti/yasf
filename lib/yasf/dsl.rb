module Yasf
  module DSL

    class Property
      include ::Yasf::Parseable

      attr_reader :name

      def initialize(name, *args, &block)
        @name = name
        @options = args.extract_options!
        @callback = block
      end

      def parse(context)
        data = scan(context)
        if @callback
          @callback.call(data)
        else
          data.text
        end
      end
    end


    class Collection
      include ::Yasf::Parseable

      attr_reader :name

      def initialize(name, *args, &block)
        @name = name
        @options = args.extract_options!
        @properties = Array.new
        instance_eval &block if block_given?
      end

      def property(name, *args, &block)
        @properties << Property.new(name, *args, &block)
      end

      def parse(context)
        results = Array.new
        scan(context).each do |data|
          result = Hash.new
          @properties.each do |property|
            result["#{property.name}"] = property.parse(data)
          end
          results << result
        end
        results
      end

    end

    class Metadata
      attr_reader :url

      def initialize
        @properties = Array.new
      end

      def base_url(url)
        @url = url
      end

      def collection(name, *args, &block)
        @properties << Collection.new(name, *args, &block)
      end

      def property(name, *args, &block)
        @properties << Property.new(name, *args, &block)
      end

      def parse(context)
        HashWithIndifferentAccess.new.tap do |results|
          @properties.each do |property|
            results[property.name] = property.parse(context) if property.is_a? ::Yasf::Parseable
          end
        end
      end

    end


  end
end
