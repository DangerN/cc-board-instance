require "json"

module CC
  # Represents a single board, represents a collection of similar `Post`s and `Thread`s.
  class Board
    include JSON::Serializable
    property id : String
    property name : String
    property flags = [] of String
    property thread_limit : UInt8 = 25
    property threads = [] of CC::Thread

    def add_thread(thread_options, post_options)
      thread = Thread.new **thread_options
      thread.add_post post_options
      @threads << thread
    end

    def new_thread(thread_options, post_options)
      puts "I should be sending a request to start a new thread"
      puts "Thread options: #{thread_options}"
      puts "Post options: #{post_options}"
    end

    def add_post(thread_id, post_options)
      thread_by_id(thread_id).add_post(post_options)
    end

    def new_post(thread_id, post_options)
      puts "I should be sending a request to start a new post"
      puts "Thread id: #{thread_id}"
      puts "Post options: #{post_options}"
    end

    def thread_by_id(thread_id)
      thread = @@threads.find { |thread| thread.id == thread_id }
      thread.not_nil!
    end
  end
end
