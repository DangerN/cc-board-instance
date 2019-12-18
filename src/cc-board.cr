require "kemal"
require "dotenv"
require "json"
require "cc-lib"
require "./cc-board/*"

class Charlie
  @@delta_connection : HTTP::WebSocket | Nil
  CC.initialize_dummy_boards

  def self.run

    Dotenv.load

    socket = HTTP::WebSocket.new("0.0.0.0", "/", port: 9002)

    socket.close

    kemal_config


    Kemal.run
  end
end

Charlie.run
