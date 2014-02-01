module Yasf
  module DSL

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
