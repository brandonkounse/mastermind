# frozen_string_literal: true

# class for the player object to play the game
class Player
  attr_accessor :role

  def initialize; end

  def guess
    gets.chomp.downcase.split(' ')
  end

  def set_hidden_code
    gets.chomp.downcase.split(' ')
  end
end
