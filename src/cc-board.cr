# require "json-socket"
# require "json"
require "kemal"
require "http/web_socket"
require "dotenv"

Dotenv.load

ws "/" do |socket|
  puts "socket open"
  socket.send "yo yo yo"
  # socket.on_message do |message|
  #   socket.send "Echo yo #{message}"
  # end
  socket.on_ping do
    puts "got pinged yo"
  end
  socket.on_close do
    puts "closed socket"
  end
end

Kemal.config.port = 42042


client_socket = HTTP::WebSocket.new("0.0.0.0","/","9001")
client_socket.send ENV["BOARD"]
client_socket.on_message do |message|
  puts message
end

spawn do
  client_socket.run
end

spawn do
  Kemal.run
end

sleep
