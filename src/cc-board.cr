require "kemal"
require "http/web_socket"
require "dotenv"
require "json"
require "cc-lib"

Dotenv.load
CC.initialize_dummy_boards
BOARD_LIST = CC.board_list

def handle_message(message : String, socket : HTTP::WebSocket)
  if (message == "base")
    {"boardList": BOARD_LIST,
      "announce": "This site is still under development."
    }
  else
    return {"error" => "Bad Request"} unless BOARD_LIST.keys.includes?(message)
    {"boardDump" => {
      "#{message}" => CC.board_by_id(message)
      }}
  end
end

def handle_update(update)
  puts update
end

# all browsing traffic handled through "/" path
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

Kemal.run
