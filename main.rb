# frozen_string_literal: true

require './mastermind'
require './player'

game = Mastermind.new

game.game_start_setup
game.play_mastermind while game.current_turn < 12
