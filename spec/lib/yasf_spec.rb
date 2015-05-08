require 'spec_helper'

describe Yasf do

  describe "Respond to" do
    it { expect(Yasf).to respond_to(:crawl) }
  end

  describe '#scrape' do
    before do
      @crawler = Fakecrawler.new.crawl
    end

    it "all values must be correct" do
      expect(@crawler.page_title).to eql('Home | Wow! eBook')
      expect(@crawler.books.count).to be(6)
      expect(@crawler.books.last.title).to eql('LEARNING ANDROID, 2ND EDITION')
    end

  end

end
