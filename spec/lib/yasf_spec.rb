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
end
