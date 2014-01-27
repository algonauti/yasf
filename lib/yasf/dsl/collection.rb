module Yasf
  module DSL


    class Collection
      attr_reader :name

      def initialize(name, *args, &block)
        @name = name
        @options = args.extract_options!
        @properties = Array.new
        instance_eval(&block) if block_given?
      end

      def selector
        @options[:xpath] || nil
      end

      def property(name, *args, &block)
        @properties << Property.new(name, *args, &block)
      end

      def parse(context)
        results = Array.new
        context.xpath(selector).each do |sub_context|
          result = Hash.new
          @properties.each do |property|
            result["#{property.name}"] = property.parse(sub_context)
          end
          results << result
        end
        results
      end

    end

  end
end
