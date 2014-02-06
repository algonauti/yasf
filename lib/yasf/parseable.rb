module Yasf
  module Parseable
    extend ActiveSupport::Concern

    included do
      attr_reader :options
    end

    def selector
      options[parser]
    end

    def scan(context)
      context.send(parser, selector)
    end

    def parser
      options[:xpath] ? :xpath : :css
    end

    def parse(context)
      puts "Call Yasf::DSL::Parseable"
    end
  end
end
