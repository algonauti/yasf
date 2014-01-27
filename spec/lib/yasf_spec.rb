require 'spec_helper'

describe Yasf do

  describe "Respond to" do
    it { Yasf.should respond_to(:crawl) }
  end

  describe '#scrape' do
    before do
      @scrape = Yasf.crawl do
        base_url "http://www.wowebook.com"

        property :page_title, xpath: '/html/head/title'

        collection :books, xpath: '//*[@id="content"]/div/article' do
          property :title, xpath: 'header/h2/a/@title'
          property :description, xpath: 'div/p'
          property :download, xpath: 'div/p/a/@href'
        end

      end
    end

    it { @scrape[:books].count.should be(6) }
  end

end
