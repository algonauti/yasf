module Yasf
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :proxy_host
    config_accessor :proxy_port
    config_accessor :timeout
    config_accessor :debug

    def poltergeist
      options = {
        js_errors: false,
        debug: false,
        inspector: false,
        timeout: timeout || 20
      }

      options.merge!(
        logger: NullLogger.new,
        phantomjs_logger: NullLogger.new
      ) unless debug?

      options.merge!(
        phantomjs_options: [
          '--ignore-ssl-errors=yes',
          "--proxy=#{proxy_host}:#{proxy_port}",
          '--proxy-type=http',
          '--web-security=no',
          '--load-images=false'
        ]
      ) if proxy?

      return options
    end

    def debug?
      !!debug
    end

    def proxy?
      proxy_host and proxy_port
    end

    private

    class NullLogger
      def puts(msg)
      end
    end

  end
end
