require 'rubygems'
require 'bundler/setup'
require 'rspec/mocks'
require 'fakeweb'

require 'yasf'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :mocha
end
