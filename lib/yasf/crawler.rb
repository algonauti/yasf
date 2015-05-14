module Yasf
  module Crawler
    extend ActiveSupport::Concern

    #
    # InstanceMethods
    #
    def crawl(&block)
      if block_given?
        self.instance_eval(&block)
      end
      Yasf::Parser.new(metadata).parse
    end

    def metadata
      self.class.send(:metadata)
    end

    def method_missing(method, *args, &block)
      self.class.send(method, *args, &block)
    end

    module ClassMethods
      def method_missing(method, *args, &block)
        metadata.send(method, *args, &block)
      end

      private

      def metadata
        @metadata ||= DSL::Metadata.new
      end
    end

  end
end
