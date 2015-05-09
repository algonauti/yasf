require 'active_support/all'

require 'yasf/version'
require 'yasf/capybara'

module Yasf
  autoload :Crawler,    'yasf/crawler'
  autoload :DSL,        'yasf/dsl'
  autoload :Parser,     'yasf/parser'
  autoload :Parseable,  'yasf/parseable'
  autoload :Session,    'yasf/session'

  class << self
    def crawl(&block)
      klass = Class.new
      klass.send(:include, Yasf::Crawler)
      klass.new.crawl(&block)
    end
  end
end
