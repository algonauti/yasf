module Yasf
  module Parseable
    extend ActiveSupport::Concern

    included do
      attr_reader :options
    end

    def selector
      options[:xpath] || options[:css] || nil
    end

    def search(context)
      context.xpath(selector)
    end

    def parse(context)
      puts "Call Yasf::DSL::Parseable"
    end
  end
end
