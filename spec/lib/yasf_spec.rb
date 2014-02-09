require 'spec_helper'

describe Yasf do

  describe "Respond to" do
    it { Yasf.should respond_to(:crawl) }
  end

  describe '#scrape' do
    before do
      @crawler = Fakecrawler.new.crawl
    end

    it "all values must be correct" do
      @crawler.page_title.should be_eql('Home | Wow! eBook')
      @crawler.books.count.should be(6)
      @crawler.books.last.title.should be_eql('LEARNING ANDROID, 2ND EDITION')
    end

  end

end
