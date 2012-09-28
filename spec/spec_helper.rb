require 'yasf'

def read_fixture(path)
  File.read(File.expand_path(File.join(File.dirname(__FILE__), "fixtures", path)))
end

FAKE_URLS = { 
  "http://www.fakeurl.com/basic_example" => "basic_example_response",
  "http://www.fakeurl.com/medium_example" => "medium_example_response",
  "http://www.fakeurl.com/advanced_example" => "advanced_example_response",
  "http://thepiratebay.se/browse/101" => "thepiratebay_response.html"
}

begin
  require 'fakeweb'

  FakeWeb.allow_net_connect = false
  FAKE_URLS.each do |url, response|
    FakeWeb.register_uri(:get, url, :body => read_fixture(response))
  end
rescue LoadError
  puts "Could not load FakeWeb. Please run 'bundle install'"
end

