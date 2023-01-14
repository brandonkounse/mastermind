# frozen_string_literal: true

require './mastermind'
require './player'

game = Mastermind.new
game.pick_role

game.play_mastermind while game.current_turn < 12
