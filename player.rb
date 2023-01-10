# frozen_string_literal: true

# class for the codebreaker and codemaker
class Player
  attr_reader :name, :role

  def initialize(role)
    @role = role
  end
end
