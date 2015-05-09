require 'capybara/poltergeist'

class NullLogger
  def puts(msg)
  end
end

module WebSocket
  class Driver
    class Server < Driver
      def initialize(socket, options = {})
        super
        @http = HTTP::Request.new
        @delegate = nil
      end
    end
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
