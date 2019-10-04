class BoardListener
  @@instance = new

  private def initialize
    puts "client initialize"
    client_socket = HTTP::WebSocket.new("0.0.0.0","/","9001")
    client_socket.send ENV["BOARD"]
    client_socket.on_message do |message|
      puts message
    end
    client_socket.run
  end

  def self.run
    @@instance
  end
end
