class Charlie
  def self.handle_message(message : String, socket : HTTP::WebSocket)
    if (message == "base")
      {"boardList": CC.board_list,
        "announce": "This site is still under development."
      }
    else
      return {"error" => "Bad Request"} unless CC.board_list.keys.includes?(message)
      {"boardDump" => {
        "#{message}" => CC.board_by_id(message)
        }}
    end
  end
end
