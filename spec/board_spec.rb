require './lib/connect_four/board'
require "spec_helper.rb"

module ConnectFour
    describe Board do
        describe "#initialize" do
            it "creates an empty board" do
                board = Board.new
                expect(board.board_matrix.uniq.length).to eql(1)
            end
            it "creates 7 columns" do
                board = Board.new
                expect(board.board_matrix.length).to eql(7)
            end
            it "creates 6 rows" do
                board = Board.new
                expect(board.board_matrix[0].length).to eql(6)
            end
        end

        describe "#move_valid?" do
            it "returns false if column is out of bounds" do
                board = Board.new
                expect(board.move_valid?(7)).to eql(false)
            end
            it "returns false if row is full" do
                board = Board.new
                3.times { board.insert_chip(0, "\u{1F534}") }
                3.times { board.insert_chip(0, "\u{1F49B}") }
                expect(board.move_valid?(0)).to eql(false)
            end
            it "returns true if column is empty" do
                board = Board.new
                expect(board.move_valid?(0)).to eql(true)
            end
            it "returns true if column is neither empty nor full" do
                board = Board.new
                2.times { board.insert_chip(0, "\u{1F534}") }
                expect(board.move_valid?(0)).to eql(true)
            end
        end

        describe "#insert_chip" do
            it "returns 1 if this completes 4 in a column" do
                board = Board.new
                3.times { board.insert_chip(0, "\u{1F534}") }
                expect(board.insert_chip(0, "\u{1F534}")).to eql(1)
            end
            it "returns 1 if this completes 4 in a row" do
                board = Board.new
                board.insert_chip(4, "\u{1F534}")
                board.insert_chip(3, "\u{1F534}")
                board.insert_chip(2, "\u{1F534}")
                expect(board.insert_chip(1, "\u{1F534}")).to eql(1)
            end
            it "returns 1 if this completes 4 in a diagonal" do
                board = Board.new
                board.insert_chip(0, "\u{1F534}")
                board.insert_chip(1, "\u{1F49B}")
                board.insert_chip(1, "\u{1F534}")
                2.times { board.insert_chip(2, "\u{1F49B}") }
                3.times { board.insert_chip(3, "\u{1F49B}") }
                board.insert_chip(3, "\u{1F534}")
                expect(board.insert_chip(2, "\u{1F534}")).to eql(1)
            end
            it "returns 0 if the game should continue" do
                board = Board.new
                board.insert_chip(0, "\u{1F534}")
                expect(board.insert_chip(0, "\u{1F49B}")).to eql(0)
            end
            it "returns -1 if the game ends in a draw" do
                board = Board.new
                3.times { board.insert_chip(0, "\u{1F534}") }
                3.times { board.insert_chip(0, "\u{1F49B}") }
                3.times { board.insert_chip(1, "\u{1F49B}") }
                3.times { board.insert_chip(1, "\u{1F534}") }
                3.times { board.insert_chip(2, "\u{1F534}") }
                3.times { board.insert_chip(2, "\u{1F49B}") }
                3.times { board.insert_chip(3, "\u{1F49B}") }
                3.times { board.insert_chip(3, "\u{1F534}") }
                3.times { board.insert_chip(4, "\u{1F534}") }
                3.times { board.insert_chip(4, "\u{1F49B}") }
                3.times { board.insert_chip(5, "\u{1F49B}") }
                3.times { board.insert_chip(5, "\u{1F534}") }
                3.times { board.insert_chip(6, "\u{1F534}") }
                2.times { board.insert_chip(6, "\u{1F49B}") }
                expect(board.insert_chip(6, "\u{1F49B}")).to eql(-1)
            end
            it "updates the game board when a token is dropped into an empty column" do
                board = Board.new
                board.insert_chip(0, "\u{1F534}")
                expect(board.board_matrix[0][0]).to eql("\u{1F534}")
            end
            it "updates the game board when a token is dropped into a non-empty column" do
                board = Board.new
                board.insert_chip(0, "\u{1F534}")
                board.insert_chip(0, "\u{1F49B}")
                expect(board.board_matrix[0][1]).to eql("\u{1F49B}")
            end
        end

        describe "#display_board" do
            it "outputs an empty board" do
                board = Board.new
                expect{board.display_board}.to output("\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n 1 2 3 4 5 6 7 \n").to_stdout
            end
            it "outputs a board with tokens" do
                board = Board.new
                board.insert_chip(0, "\u{1F534}")
                board.insert_chip(0, "\u{1F49B}")
                expect{board.display_board}.to output("\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F49B}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n\u{1F534}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\u{1F535}\n -+-+-+-+-+-+-\n 1 2 3 4 5 6 7 \n").to_stdout
            end
        end
    end
end