Billy.configure do |c|
  c.cache = true
  c.persist_cache = true
end

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

