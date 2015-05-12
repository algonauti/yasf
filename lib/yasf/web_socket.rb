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
