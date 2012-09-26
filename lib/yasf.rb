require "open-uri"

require "yasf/version"
require "yasf/scraper"

module Yasf
  class << self
    def define(&block)
      kls = Class.new(Scraper)
      kls.module_eval &block if block_given?
      return kls
    end
  end

end
