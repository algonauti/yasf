Billy.configure do |c|
  c.cache = true
  c.persist_cache = true
end

Billy.config.logger.level = Logger::ERROR

Capybara.default_driver = :poltergeist_billy

# Monkey patch for eventmachine_httpserver
module EventMachine
	class HttpResponse
		def initialize
			super
      @keep_connection_open = true
      @sent_content = false
      @sent_headers = false
		end
  end
end

# Monkey patch for removing
# warning: instance variable @ssl not initialized
module Billy
  class ProxyConnection < EventMachine::Connection
    def on_message_complete
      if @parser.http_method == 'CONNECT'
        restart_with_ssl(@parser.request_url)
      else
        if defined?(@ssl) and @ssl  # The only line I changed
          uri = Addressable::URI.parse(@parser.request_url)
          @url = "https://#{@ssl}#{[uri.path, uri.query].compact.join('?')}"
        else
          @url = @parser.request_url
        end
        handle_request
      end
    end
  end
end

# Monkey patch for removing
# warning: instance variable @cache not initialized
# warning: instance variable @signature not initialized
module Billy
  class Proxy

    def start(threaded = true)
      if threaded
        Thread.new { main_loop }
        sleep(0.01) while (not defined?(@signature)) or @signature.nil?  # The only line I changed
      else
        main_loop
      end
    end

    protected

    def main_loop
      EM.run do
        EM.error_handler do |e|
          Billy.log :error, "#{e.class} (#{e.message}):"
          Billy.log :error, e.backtrace.join("\n")
        end

        @signature = EM.start_server('127.0.0.1', Billy.config.proxy_port, ProxyConnection) do |p|
          p.handler = request_handler
          p.cache = @cache if defined?(@cache)  # The only line I changed
        end

        Billy.log(:info, "puffing-billy: Proxy listening on #{url}")
      end
    end
  end
end