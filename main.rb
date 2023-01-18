# frozen_string_literal: true

require './mastermind'
require './player'

game = Mastermind.new

game.game_start_setup

while game.turn < 12
  game.play_mastermind
  break if game.game_over == true
end
