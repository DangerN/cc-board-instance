class Charlie
  def self.kemal_config
    ws "/" do |socket|
      CC.sockets.push socket

      socket.on_message do |message|
        socket.send handle_message(message, socket).to_json
      end

      socket.on_close do |_|
        CC.sockets.delete(socket)
        puts "Closed socket: #{socket}"
      end
    end

    Kemal.config.port = 42042
    
  end
end
