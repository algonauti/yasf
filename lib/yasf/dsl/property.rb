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
        data = search(context)
        if @callback
          @callback.call(data)
        else
          data.text
        end
      end
    end

  end
end
