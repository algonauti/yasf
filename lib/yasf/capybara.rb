require 'capybara/poltergeist'

class NullLogger
  def puts(msg)
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors: false,
    debug: false,
    inspector: false,
    timeout: 20,
    logger: NullLogger.new,
    phantomjs_logger: NullLogger.new
  )
end

Capybara.default_driver = :poltergeist
