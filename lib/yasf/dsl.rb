module Yasf
  module DSL


    module Node
      attr_reader :name

      include ::Yasf::Parseable

      def initialize(name, *args, &block)
        @name = name
        @options = args.extract_options!

        if block_given? && block.arity == 0
          self.instance_eval &block
        else
          @callback = block
        end
      end
    end

    module Language
      def collection(name, *args, &block)
        properties << Collection.new(name, *args, &block)
      end

      def property(name, *args, &block)
        properties << Property.new(name, *args, &block)
      end

      def properties
        @properties ||= []
        @properties
      end

    end

    class Property
      include Node

      def parse(context)
        raw_data = scan(context)
        if fields.empty?
          @callback.call(raw_data) rescue raw_data.text
        else
          OpenStruct.new.tap do |results|
            fields.each do |key, field_proc|
              results.send "#{key}=", raw_data.present? ? field_proc.call(raw_data) : nil
            end
          end
        end
      end

      def field(name)
        fields[name] = lambda do |node_set|
          node_set.attribute(name.to_s).to_s
        end
      end

      private

      def fields
        @fields ||= {}
        @fields
      end
    end

    class Collection
      include Node
      include Language

      def parse(context)
        results = Array.new
        scan(context).each do |data|
          OpenStruct.new.tap do |result|
            properties.each do |property|
              result.send "#{property.name}=", property.parse(data)
            end
            results << result
          end
        end
        results
      end

    end

    class Metadata < OpenStruct
      include Language

      attr_reader :url

      def base_url(url)
        @url = url
      end

      def parse(context)
        properties.each do |property|
          self.send "#{property.name}=", property.parse(context)
        end
        self
      end

    end


  end
end
