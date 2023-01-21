# frozen_string_literal: true

# class for the codebreaker and codemaker
class Player
  attr_reader :role

  def initialize(role)
    @role = role
  end

  def guess
    gets.chomp.downcase.split(' ')
  end
end
