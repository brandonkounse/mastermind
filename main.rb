# frozen_string_literal: true

require './mastermind'
require './player'
require './computer'

game = Mastermind.new

game.add_player(Player.new)
game.add_opponent(Computer.new)
game.setup

while game.turn <= Mastermind::MAX_TURNS
  game.play
  break if game.over == true
end
