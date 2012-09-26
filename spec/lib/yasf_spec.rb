require 'spec_helper'

describe Yasf do
  it "should be created new scraper without block" do
    scraper = Yasf::define
    scraper.should_not be_nil
    scraper.ancestors.should be_include(Yasf::Scraper)
  end

  it "should be raised error sintax with wrong selector" do
    url = "http://www.fakeurl.com/basic_example"

    scraper = Yasf::define do
      scrape :title, "2h1.title", :title => :text
      result :title
    end

    lambda {
      title = scraper.extract_from(url)
    }.should raise_error(Nokogiri::CSS::SyntaxError)

  end

  it "scrape basic example content" do
    url = "http://www.fakeurl.com/basic_example"

    scraper = Yasf::define do
      scrape :title, "h1.title", :title => :text
      result :title
    end

    title = scraper.extract_from(url)
    title.should be_eql("Title 1")
  end

  it "scrape medium example content and result should be stored in array" do
    url = "http://www.fakeurl.com/medium_example"
    scraper = Yasf::define do
      scrape :title, "h1.title", :'titles[]' => :text
      result :titles
    end
    titles = scraper.extract_from(url)
    titles.should be_is_a(Array)
  end

  it "scrape advanced example content and  should be to have more results" do
    url = "http://www.fakeurl.com/advanced_example"

    title = Yasf::define do
      scrape :title, "h1.title_under_table", :title => :text
      scrape :links, "a.title_under_table", :link_name => :text, :link_url => :href

      result :title, :link_name, :link_url
    end
    scraper = Yasf::define do
      scrape :titles, "table tr.tr_with_title", :'titles[]' => title

      result :titles
    end

    titles = scraper.extract_from(url)
    titles.should be_is_a(Array)
    titles.size.should be_equal(5)
    titles[3].title.should be_eql("Title 4")
  end

end
