require "./cc-lib/*"
require "json"

# TODO: Write documentation for `CC::Library`
module CC
  VERSION = "0.2.1"
  @@boards = [] of Board
  @@subscriptions = {} of String => Array(HTTP::WebSocket)
  @@sockets = [] of HTTP::WebSocket

  def self.subscriptions
    @@subscriptions
  end

  def self.sockets
    @@sockets
  end

  def self.boards
      @@boards
  end

  # Takes a JSON object representing a `Board`
  def self.initialize_board_from_json(board)
    @@boards << Board.from_json(board)
  end

  def self.initialize_dummy_boards
    initialize_board_from_json(%({"id":"fit", "name":"Fitness", "threads":[{"id":34003}]}))
    initialize_board_from_json(%({
      "id":"ck",
      "name":"Cooking",
      "flags": ["sfw"],
      "threads":[{
        "id":43003,
        "posts":[{
          "id":892345720934,
          "text":"sux butts"
          },{
            "id":892345720937,
            "text":"no u"
            }]
            }]
            }))
  end

  def self.board_by_id(board_id)
    board = @@boards.find { |board| board.id == board_id }
    board.not_nil!
  end


end


# CC.initialize_dummy_boards
# fit = CC.board_by_id "fit"
# puts fit.id
#
# fit.add_thread({id: 20789.to_u32}, {id: 82709208954.to_u64, text: "yeet"})
