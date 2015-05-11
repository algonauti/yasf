require 'spec_helper'

describe Yasf do

  describe "Respond to instance methods" do
    it { expect(Yasf).to respond_to(:crawl) }
  end

  describe '#scrape' do

    context 'wowebook' do

      before do
        Billy.configure do |c|
          c.cache_path = 'spec/billy/yasf_scrape_wowebook'
          c.merge_cached_responses_whitelist = Fakecrawler::UNIMPORTANT_DOMAINS
        end
      end

      Given(:scraper) { Fakecrawler.new }
      When(:result) { scraper.crawl }

      Then { expect(result.page_title).to eql('Wow! eBook › The best eBook site ever!') }
      And { expect(result.books.count).to be(6) }
      And { expect(result.books.last.title).to eql('FIVE STARS: PUTTING ONLINE REVIEWS TO WORK FOR YOUR BUSINESS') }
    end

  end

end
