module Yasf
  class Session

    def initialize(url)
      @url = url
    end

    def html
      session = Capybara::Session.new(:poltergeist)
      session.visit @url
      session.html
    end

  end
end
