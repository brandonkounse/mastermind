# frozen_string_literal: true

require './mastermind'
require './player'

game = Mastermind.new
p game.code_maker

while game.current_turn < 12
  game.play_mastermind
end
