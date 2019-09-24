require "json-socket"
require "json"

module Board
  class Test
    def test
      puts "this is a test yo"
    end
  end
end

struct CustomJSONSocketServer

  include JSONSocket::Server

  def on_message(message, socket)
    puts message
    result = (message["a"].as_i + message["b"].as_i) * message["b"].as_i * message["a"].as_i
    self.send_end_message({ :result => result}, socket)
  end

end

data = File.open("src/mock_data.json") do |file|
  JSON.parse(file)
end
puts data
test = Board::Test.new
test.test

server = CustomJSONSocketServer.new("127.0.0.1", 1234)
server.listen
