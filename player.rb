# frozen_string_literal: true

# class for the codebreaker and codemaker
class Player
  attr_reader :name, :role

  def initialize(role, name)
    @role = role
    @name = name
  end
end
