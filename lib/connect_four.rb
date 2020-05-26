# lib/connect_four.rb

require_relative "./connect_four/board.rb"
require_relative "./connect_four/game.rb"
require_relative "./connect_four/players.rb"

module ConnectFour
    class Error < StandardError; end
end

game = ConnectFour::Game.new
game.start_game