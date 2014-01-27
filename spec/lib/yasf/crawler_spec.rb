require 'spec_helper'

describe Yasf::Crawler do
  before(:each) do
    @crawler = Class.new
    @crawler.send(:include, Yasf::Crawler)
    @instance = @crawler.new
  end

  describe "Respond to instance methods" do
    it { @instance.should respond_to(:crawl) }
  end
end
