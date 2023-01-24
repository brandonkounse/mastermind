# frozen_string_literal: true

require './player'

# class for the computer opponent to play against
class Computer < Player
  attr_accessor :role

  def guess
    random_colors = []
    until random_colors.length == 4
      random_guess = rand(6)
      random_colors.push(random_guess) unless random_colors.include?(random_guess)
    end
    random_colors
  end
end
