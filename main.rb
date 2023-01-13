# frozen_string_literal: true

require './mastermind'
require './player'

game = Mastermind.new
game.pick_role

while game.current_turn < 12
  game.play_mastermind
end
