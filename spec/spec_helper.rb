require 'rubygems'
require 'bundler/setup'
require 'dotenv'
require 'rspec/given'
require 'rspec/mocks'
require 'webmock/rspec'

Dotenv.load('.env')

require 'yasf'

RSpec.configure do |config|
  config.before :suite do
    Yasf.configure do |config|
      config.timeout = 60
    end
  end

  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = :random
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.warnings = true
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
