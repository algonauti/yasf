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

          property :title, xpath: 'header/h2/a/@title'do |data|
            data.to_s.upcase
          end

          property :description, xpath: 'div/p'

          property :download, xpath: 'div/p/a' do
            field :href
            field :title
          end

        end

      end
    end

    it "all values must be correct" do
      @scrape.page_title.should be_eql('Home | Wow! eBook')
      @scrape.books.count.should be(6)
      @scrape.books.last.title.should be_eql('LEARNING ANDROID, 2ND EDITION')
    end

  end

end
