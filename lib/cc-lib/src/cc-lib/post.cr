module CC
  # Belongs to a single `Thread` and `Board`.
  class Post
    include JSON::Serializable
    property id : UInt64
    property badges = [] of String
    property flags = [] of String
    property text : String = ""
    property media_link : String = ""

    def initialize(@id : UInt64, @badges = [] of String, @flags = [] of String, @text = "", @media_link = "")

    end

  end
end
