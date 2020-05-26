# lib/connect_four/game.rb

require_relative "players.rb"
require_relative "board.rb"

module ConnectFour
    class Game
        def initialize
            puts "Connect Four!\n"
            @game_board = Board.new
            @players = Players.new
        end

        def start_game
            puts "Player 1, enter your name:"
            player_one_name = gets.chomp
            @players.player1_name = player_one_name

            puts "Player 2, enter your name:"
            player_two_name = gets.chomp
            @players.player2_name = player_two_name

            puts "#{@players.player1_name} Chip: #{"\u{1F534}"}"
            puts "#{@players.player2_name} Chip: #{"\u{1F49B}"}"

            puts "#{@players.player1_name}, make a move!\n"
            play_game
        end

        def play_game
            game_over = false
            until game_over
                valid_move = false
                until valid_move
                    @game_board.display_board
                    puts "It's #{@players.current_player}'s turn. Select a column: "
                    column = gets.chomp.to_i
                    if @game_board.move_valid?(column - 1)
                        valid_move = true 
                    end
                end
                result = @game_board.insert_chip(column - 1, @players.current_token)
                if result == -1
                    @game_board.display_board
                    puts "It's a draw."
                    game_over = true
                elsif result == 1
                    @game_board.display_board
                    puts "#{@players.current_player} wins!"
                    game_over = true
                else
                    @players.switch_player
                end
            end
        end
    end
end