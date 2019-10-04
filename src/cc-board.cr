require "kemal"
require "http/web_socket"
require "dotenv"
require "./board_server.cr"
require "./board_listener.cr"

Dotenv.load

puts "what the fug"

spawn do
  puts "trying to start listener"
  BoardListener.run
end

spawn do
  puts "starting server"
  BoardServer.run
end

sleep

# spawn do
#   sleep 3
#   client_socket.close
# end
