require 'rest_client'
require 'nokogiri'

module Yasf

  class Parser
    attr_reader :metadata

    def initialize(metadata)
      @metadata = metadata
    end

    def parse
      @metadata.parse(document)
    end

    private

    def document
      Nokogiri::HTML(
        RestClient.get(@metadata.url)
      )
    end

  end
end
