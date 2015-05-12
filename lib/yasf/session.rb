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
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(
          app, Yasf.config.poltergeist
        )
      end
      Capybara.default_driver = :poltergeist
    end
  end
end
