# lib/connect_four/game.rb

require_relative "player.rb"
require_relative "board.rb"

module ConnectFour
    class Game

        attr_accessor :game_board
        def initialize
            puts "Connect Four!\n"
            @game_board = Board.new
            @count = 0
        end

        def red_chip
            red_chip = "\u{1F534}"
        end

        def yellow_chip
            yellow_chip = "\u{1F781}"
        end

        def start_game
            puts "Player 1, enter your name:"
            player_one_name = gets.chomp
            @player_one = Player.new(player_one_name, red_chip)

            puts "Player 2, enter your name:"
            player_two_name = gets.chomp
            @player_two = Player.new(player_two_name, yellow_chip)

            puts "#{@player_one.player_name} Chip: #{red_chip}"
            puts "#{@player_two.player_name} Chip: #{yellow_chip}"

            puts "#{@player_one.player_name}, make a move!\n"
            @game_board.display_board
            play_game
        end

        def play_game
            while @count <= 42
                # Player one turn
                pick_column(@player_one)
                insert_chip(@player_one)
                @game_board.display_board
                is_game_over(@player_one)

                # Player two turn
                pick_column(@player_two)
                insert_chip(@player_two)
                @game_board.display_board
                is_game_over(@player_two)
            end

            puts "Nice job! It's a draw."
            exit!
        end

        def pick_column(player)
            puts "Pick a column: "
            @column = gets.chomp.to_i - 1
            if !valid_move?
                pick_column(player)
            end
        end

        def valid_move?
            if @game_board.board_matrix[@column][5] == "\u{26AB}"
                return true
            else
                puts "Column is full."
                return false
            end
        end

        def insert_chip(player)
            @game_board.board_matrix[@column].each_with_index do |slot, index|
                if slot == "\u{26AB}"
                    @game_board.board_matrix[@column][index] = player.player_piece
                    @count += 1
                    break
                end
            end
        end

        def is_game_over(player)
            if @game_board.victory?
                puts "#{player.player_name} won! Good job."
                exit!
            end
        end
    end
end