require 'active_support/all'
require 'capybara/poltergeist'

require 'yasf/version'
require 'yasf/web_socket'

module Yasf
  autoload :Crawler,        'yasf/crawler'
  autoload :DSL,            'yasf/dsl'
  autoload :Parser,         'yasf/parser'
  autoload :Parseable,      'yasf/parseable'
  autoload :Session,        'yasf/session'
  autoload :Configuration,  'yasf/configuration'

  class << self

    def configure
      yield config if block_given?
    end

    def config
      @config ||= Configuration.new
    end

    def crawl(&block)
      klass = Class.new
      klass.send(:include, Yasf::Crawler)
      klass.new.crawl(&block)
    end

  end
end
