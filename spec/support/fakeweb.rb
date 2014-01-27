def read_fixture(path)
  File.read(File.expand_path(File.join(File.dirname(__FILE__), '..',"fixtures", path)))
end

FAKE_URLS = {
  'http://www.wowebook.com/' => 'wowebook.com.html'
}

begin

  FakeWeb.allow_net_connect = false
  FAKE_URLS.each do |url, response|
    FakeWeb.register_uri(:get, url, :body => read_fixture(response))
  end
rescue LoadError
  puts "Could not load FakeWeb. Please run 'bundle install'"
end
