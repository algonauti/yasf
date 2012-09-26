require "spec_helper"

describe Yasf::Scraper do

  describe ".result" do
    it "raises without arguments" do
      lambda {
       Yasf::Scraper::result
      }.should raise_error(ArgumentError, "one symbol to return the value of this accessor")
    end

    it "Return a proc with two or more symbols" do
       Yasf::Scraper::result(:one, :tow, :three).should be_a(Proc)
    end

  end
end

