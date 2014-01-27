require 'rest_client'
require 'nokogiri'

module Yasf

  class Parser
    attr_reader :metadata

    def initialize(metadata)
      @metadata = metadata
    end

    def parse
      @metadata.parse(context)
    end

    private

    def context
      Nokogiri::HTML(
        RestClient.get(@metadata.url)
      )
    end

  end
end
