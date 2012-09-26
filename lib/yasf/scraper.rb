module Yasf
  class Scraper

    class << self

      def result(*symbols)
        raise ArgumentError, "one symbol to return the value of this accessor" if symbols.empty?
        symbols = symbols.map {|s| s.to_sym}
        if symbols.size == 1
          define_method :result do
            return self.send(symbols[0])
          end
        else
          struct = Struct.new(*symbols)
          define_method :result do
            return struct.new(*symbols.collect {|s| self.send(s) })
          end
        end
      end

    end

  end
end
