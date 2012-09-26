require 'spec_helper'

describe Yasf do
  it "should be created new scraper without block" do
    scraper = Yasf::define
    scraper.should_not be_nil
    scraper.ancestors.should be_include(Yasf::Scraper)
  end

end
