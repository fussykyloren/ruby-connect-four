# lib/connect_four/player.rb

module ConnectFour
    class Player
        attr_accessor :player_name, :player_piece

        def initialize(player_name, player_piece)
            @player_name = player_name
            @player_piece = player_piece
        end
    end
end