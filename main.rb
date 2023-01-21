# frozen_string_literal: true

require './mastermind'
require './player'

game = Mastermind.new
player = Player.new
computer = Computer.new

game.add_player(player)
game.add_opponent(computer)
game.setup

while game.turn < Mastermind::MAX_TURNS
  game.play
  break if game.over == true
end
