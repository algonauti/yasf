module Yasf
  class Configuration
    include ActiveSupport::Configurable

    config_accessor :proxy
    config_accessor :timeout

    def poltergeist
      default_options = {
        js_errors: false,
        debug: false,
        inspector: false,
        timeout: 20,
        logger: NullLogger.new,
        phantomjs_logger: NullLogger.new
      }
      default_options.merge!(
        phantomjs_options: [
          '--ignore-ssl-errors=yes',
          "--proxy=#{proxy}"
        ]
      ) if proxy
      default_options
    end


    private

    class NullLogger
      def puts(msg)
      end
    end

  end
end
