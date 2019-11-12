require "kemal"
require "http/web_socket"
require "dotenv"
require "json"
require "cc-lib"

Dotenv.load

BOARD_LIST = {
  "fit": {"name": "Fitness"},
  "ck": {"name": "Food and Cooking"},
  "v": {"name": "Video Games"}
}

CC.initialize_dummy_boards

def handle_message(message : String, socket : HTTP::WebSocket)
  if (message == "base")
    {"boardList": BOARD_LIST}
  else
    return "Bad Request" unless BOARD_LIST.keys.includes?(message)
    CC.subscriptions[message].push socket
    CC.board_by_id message
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

ws "/updates" do |socket|
  socket.on_message do |message|
    handle_update message
  end
end

Kemal.config.port = 42042

Kemal.run
