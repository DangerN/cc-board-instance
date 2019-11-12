require "json"

module CC
  # Belongs to a single `Board` and contains many `Post`s.
  class Thread
    include JSON::Serializable
    property id : UInt32
    property flags = [] of String
    property post_limit : UInt16 = 350
    property posts = [] of CC::Post

    def initialize(@id : UInt32, @flags = [] of String, @post_limit : UInt16 = 350, @posts = [] of CC::Post)

    end

    def add_post(post_options)
      @posts << CC::Post.new **post_options
    end
  end
end
