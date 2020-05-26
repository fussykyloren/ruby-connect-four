# lib/connect_four/board.rb

module ConnectFour
    class Board

        attr_reader :board_matrix
        def initialize
            @move_number = 0
            @board_matrix = Array.new(7) { Array.new(6) }
            for col in 0..6
                for row in 0..5
                    @board_matrix[col][row] = "\u{1F535}"
                end
            end
        end

        def display_board
            board_display = ""
            row_seperator = "\n -+-+-+-+-+-+-\n"

            for row in [5,4,3,2,1,0]
                for col in 0..6
                    print "#{@board_matrix[col][row]}"
                end
                print row_seperator
            end

            puts " 1  2  3  4  5  6  7 "
        end

        def is_draw?
            @move_number == 42
        end

        def move_valid?(col)
            return false if col < 0 || col > 6 || @board_matrix[col][5] != "\u{1F535}"
            return true
        end

        def insert_chip(col, chip)
            row_index = @board_matrix[col].index("\u{1F535}")
            @board_matrix[col][row_index] = chip
            @move_number += 1
            return 1 if victory?(col, row_index)
            return -1 if is_draw?
            return 0
        end

        def victory?(col, row)
            victory_column?(col) || victory_row?(row) ||  victory_diagonal?(col, row)
        end

        def victory_column?(col)
            if @board_matrix[col].count("\u{1F535}") > 2
                return false
            end

            winning_combinations = Array.new
            winning_combinations.push(@board_matrix[col][0..3].uniq.length)
            winning_combinations.push(@board_matrix[col][1..4].uniq.length)
            winning_combinations.push(@board_matrix[col][2..5].uniq.length)
            if winning_combinations.include?(1)
                return true
            else
                return false
            end
        end

        def victory_row?(row)
            row_values = Array.new
            for col in 0..6
                row_values.push(@board_matrix[col][row])
            end

            if @board_matrix[col].count("\u{1F535}") > 3
                return false
            end

            winning_combinations = Array.new
            winning_combinations.push(row_values[0..3].uniq.length)
            winning_combinations.push(row_values[1..4].uniq.length)
            winning_combinations.push(row_values[2..5].uniq.length)
            winning_combinations.push(row_values[3..6].uniq.length)

            if winning_combinations.include?(1)
                return true
            else
                return false
            end
        end

        def victory_diagonal?(col, row)
            winning_combinations = Array.new
            for col in 0..3
                for row in 0..2
                    diagonal_values = [@board_matrix[col][row]]
                    diagonal_values.push(@board_matrix[col + 1][row + 1])
                    diagonal_values.push(@board_matrix[col + 2][row + 2])
                    diagonal_values.push(@board_matrix[col + 3][row + 3])
                    if diagonal_values.count("\u{1F535}") <= 3
                        winning_combinations.push(diagonal_values.uniq.length)
                    end
                end
                for row in 3..5
                    diagonal_values = [@board_matrix[col][row]]
                    diagonal_values.push(@board_matrix[col + 1][row - 1])
                    diagonal_values.push(@board_matrix[col + 2][row - 2])
                    diagonal_values.push(@board_matrix[col + 3][row - 3])
                    if diagonal_values.count("\u{1F535}") <= 3
                        winning_combinations.push(diagonal_values.uniq.length)
                    end
                end
            end
            
            if winning_combinations.include?(1)
                return true
            else
                return false
            end
        end
    end
end