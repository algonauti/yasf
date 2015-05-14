module Yasf
  class Session

    def initialize(url)
      setup_capybara_default_driver
      @url = url
    end

    def html
      session = Capybara::Session.new(Capybara.default_driver)
      session.visit @url
      session.html
    end

    private

    def setup_capybara_default_driver
      Capybara.register_driver Yasf.config.capybara_driver do |app|
        Capybara::Poltergeist::Driver.new(
          app, Yasf.config.capybara_driver_options
        )
      end if Yasf.config.capybara_driver_options
      Capybara.default_driver = Yasf.config.capybara_driver
    end
  end
end
