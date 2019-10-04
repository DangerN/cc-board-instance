require "kemal"

class BoardServer
    property board

    @@instance = new

    def initialize
      ws "/" do |socket|
        puts "socket open"
        socket.send "yo yo yo"
        socket.on_ping do
          puts "got pinged yo"
        end
        socket.on_close do
          puts "closed socket"
        end
      end
      Kemal.config.port = 42042
      Kemal.run
    end

    def self.run
      @@instance
    end
end
