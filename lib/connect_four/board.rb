# lib/connect_four/board.rb

module ConnectFour
    class Board

        attr_reader :board_matrix
        def initialize
            @board_matrix = Array.new(7, "\u{26AB}") { Array.new(6)}
        end

        def display_board
            board_display = ""
            =begin row_seperator = "\n------+------+------+------+------+------+------"
            board_display += " #{board[0][5]} | #{board[1][5]} | #{board[2][5]} | #{board[3][5]} | #{board[4][5]} | #{board[5][5]} | #{board[6][5]}"
            board_display += row_seperator
            board_display += " #{board[0][4]} | #{board[1][4]} | #{board[2][4]} | #{board[3][4]} | #{board[4][4]} | #{board[5][4]} | #{board[6][4]}"
            board_display += row_seperator
            board_display += " #{board[0][3]} | #{board[1][3]} | #{board[2][3]} | #{board[3][3]} | #{board[4][3]} | #{board[5][3]} | #{board[6][3]}"
            board_display ++ row_seperator
            board_display += " #{board[0][2]} | #{board[1][2]} | #{board[2][2]} | #{board[3][2]} | #{board[4][2]} | #{board[5][2]} | #{board[6][2]}"
            board_display += row_seperator
            board_display += " #{board[0][1]} | #{board[1][1]} | #{board[2][1]} | #{board[3][1]} | #{board[4][1]} | #{board[5][1]} | #{board[6][1]}"
            board_display += row_seperator
            board_display += " #{board[0][0]} | #{board[1][0]} | #{board[2][0]} | #{board[3][0]} | #{board[4][0]} | #{board[5][0]} | #{board[6][0]}" =end

            6.times do |i|
                7.times do |j|
                    board_display += "  #{board[j - 1][5 - i]}  "
                end
                board_display += row_seperator
            end

            board_display += "\n  1      2      3      4      5      6      7  \n"
            p board_display
        end

        def is_connected?(arr)
            arr.size == 4 && arr.uniq.size == 1 && arr[0] != "\u{26AB}"
        end

        def victory_column?(board = @board_matrix)
            board.each do |col|
                col.each_index do |i, arr = []|
                    4.times do {|x| arr << col[i + x]}
                    return true if is_connected?(arr)
                end
            end
        end

        def victory_row?(board = @board_matrix)
            victory_column?(board.transpose)
        end

        def victory_diagonal_down?(board = @board_matrix)
            board.each do |col|
                board[col].each_index do |row, arr = []|
                    4.times do {|x| arr < board[col + x][row + x] if board[col + x]}
                    return true if is_connected?(arr)
                end
            end
        end

        def victory_diagonal_up?(board = @board_matrix)
            victory_diagonal_down?(board.map(&:reverse))
        end

        def victory?
            victory_column? || victory_row? || victory_diagonal_down? || victory_diagonal_up?
        end
    end
end