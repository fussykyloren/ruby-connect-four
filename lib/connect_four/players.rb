# lib/connect_four/players.rb

module ConnectFour
    class Players
        attr_reader :current_player, :current_token
        attr_accessor :player1_name, :player2_name
    
        def initialize(player1_name = "a", player2_name = "b")
            @player1_name = player1_name
            @player2_name = player2_name
            @current_player = @player1_name
            @current_token = "\u{1F534}"
        end
    
        def switch_player
            if @current_player == @player1_name
                @current_player = @player2_name
                @current_token = "\u{1F49B}"
            else
                @current_player = @player1_name
                @current_token = "\u{1F534}"
            end
        end
    end
end