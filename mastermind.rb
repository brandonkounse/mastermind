# frozen_string_literal: true

require 'colorize'

# mastermind main class
class Mastermind
  attr_reader :hidden_code, :default_colors, :player, :computer

  def initialize
    @default_colors = %w[white magenta red blue green yellow]
    set_hidden_code
  end

  def guess_hidden_code
    guess = gets.chomp
    guess_hidden_code if validate_guess(guess)
  end

  private

  def set_hidden_code
    @hidden_code = @default_colors.dup
    @hidden_code.delete_at(rand(@hidden_code.length)) while @hidden_code.length > 4
  end

  def validate_guess(guess)
    if guess.length != 4
      true
    else
      guess.split('').any? { |num| p num.to_i < 1 || num.to_i > 6 } == true
    end
  end
end
