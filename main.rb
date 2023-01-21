# frozen_string_literal: true

require './mastermind'
require './player'

game = Mastermind.new

game.game_start_setup

while game.turn < Mastermind::MAX_TURNS
  game.play
  break if game.over == true
end
