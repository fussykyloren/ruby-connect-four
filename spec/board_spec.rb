require 'board.rb'

describe Board do
    describe "#display_board" do
        it "shows a game board" do 
            expect(STDOUT).to receive(:puts).exactly(14).times
            subject.display_board
        end
    end

    describe "#victory?" do 
        it "checks for vertical victory" do
            subject.board[0][0] = "\u{1F534}"
            subject.board[0][1] = "\u{1F534}"
            subject.board[0][2] = "\u{1F534}"
            subject.board[0][3] = "\u{1F534}"
            expect(subject).to be_victory 
        end

        it "checks for horizontal victory" do
            subject.board[0][0] = "\u{1F534}"
            subject.board[1][0] = "\u{1F534}"
            subject.board[2][0] = "\u{1F534}"
            subject.board[3][0] = "\u{1F534}"
            expect(subject).to be_victory 
        end

        it "checks for diagonal up victory" do
            subject.board[0][0] = "\u{1F534}"
            subject.board[1][1] = "\u{1F534}"
            subject.board[2][2] = "\u{1F534}"
            subject.board[3][3] = "\u{1F534}"
            expect(subject).to be_victory
        end  
        
        it "checks for diagonal down victory" do
            subject.board[0][5] = "\u{1F534}"
            subject.board[1][4] = "\u{1F534}"
            subject.board[2][3] = "\u{1F534}"
            subject.board[3][2] = "\u{1F534}"
            expect(subject).to be_victory
        end  
        
        it "does not accept non-victory as victory" do
            subject.board[0][2] = "\u{1F534}"
            subject.board[1][3] = "\u{1F534}"
            subject.board[2][1] = "\u{1F534}"
            subject.board[2][0] = "\u{1F534}"
            expect(subject).not_to be_victory
        end
    end
end