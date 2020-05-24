require 'game.rb'

describe Game do
    describe "#game_start" do
        it "starts the game" do
            expect(subject).to receive(:play_game)
            subject.game_start
        end
    end

    describe "#insert" do
        it "inserts chip into board" do
            game = Game.new
            player = Player.new("Frank", "\u{1F534}")
            column = 0
            board = Board.new
            game.instance_variable_set(:@player_one, player)
            game.instance_variable_set(:@column, column)
            game.instance_variable_set(:@game, board)
            game.insert(player)
            expect(board.board[column][0]).to eq("\u{1F534}")
        end
    end
    
    describe "#game_over" do
        it "exits game" do
            game = Game.new
            p1 = Player.new("Michael", "X")
            game.instance_variable_set(:@player_one, p1)
            expect(game).to receive(:exit!)
            game.game_over(p1)
        end
    end