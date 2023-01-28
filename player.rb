# frozen_string_literal: true

# class for the player object to play the game
class Player
  attr_accessor :role

  def initialize; end

  def guess
    gets.chomp.downcase.split(' ')
  end

  def set_role
    role = gets.chomp

    case role.to_i
    when 1
      @role = :codemaker
    when 2
      @role = :codebreaker
    end
  end
end
