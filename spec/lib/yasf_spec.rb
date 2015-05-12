require 'spec_helper'

describe Yasf do

  describe "Respond to instance methods" do
    it { expect(Yasf).to respond_to(:crawl) }
  end

  describe '#scrape', vcr: true do

    context 'wowebook' do
      Given(:scraper) { Fakecrawler.new }
      When(:result) { scraper.crawl }

      Then { expect(result.page_title).to eql('Wow! eBook › The best eBook site ever!') }
      And { expect(result.books.count).to be(6) }
      And { expect(result.books.last.title).to eql('FIVE STARS: PUTTING ONLINE REVIEWS TO WORK FOR YOUR BUSINESS') }
    end

  end
end
