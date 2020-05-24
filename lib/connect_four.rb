# lib/connect_four.rb

require_relative "./lib/board.rb"
require_relative "./lib/game.rb"
require_relative "./lib/player.rb"

module ConnectFour
    class Error < StandardError; end
end

game = Game.new
game.start_game