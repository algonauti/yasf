module Yasf
  module DSL

    class Property
      attr_reader :name

      def initialize(name, *args, &block)
        @name = name
        @options = args.extract_options!
        @callback = block
      end

      def selector
        @options[:xpath] || nil
      end

      def parse(context)
        data = context.xpath(selector)
        if @callback
          @callback.call(data)
        else
          data.text
        end
      end
    end

  end
end
