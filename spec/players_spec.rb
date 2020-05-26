require './lib/connect_four/players'
require "spec_helper.rb"

module ConnectFour
    describe Players do
        describe "#initialize" do
            it "sets the first player as the current player" do
                players = Players.new("Kylo","Rey")
                expect(players.current_player).to eql("Kylo")
            end
            it "sets the first player's token color to black" do
                players = Players.new("Kylo", "Rey")
                expect(players.current_token).to eql("\u{1F534}")
            end
        end

        describe "#switch_player" do
            it "switches from player 1 to player 2" do
                players = Players.new("Kylo","Rey")
                players.switch_player
                expect(players.current_player).to eql("Rey")
            end
            it "switches from player 2 to player 1" do
                players = Players.new("Kylo","Rey")
                2.times { players.switch_player }
                expect(players.current_player).to eql("Kylo")
            end
            it "switches the current token color to red" do
                players = Players.new("Kylo", "Rey")
                players.switch_player
                expect(players.current_token).to eql("R")
            end
            it "switches the current token color to black" do
                players = Players.new("Kylo","Rey")
                2.times { players.switch_player }
                expect(players.current_token).to eql("B")
            end
        end
    end
end