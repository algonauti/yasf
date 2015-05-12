module Yasf
  class Session

    def initialize(url)
      @url = url
    end

    def html
      session = Capybara::Session.new(Capybara.default_driver)
      session.visit @url
      session.html
    end

  end
end
