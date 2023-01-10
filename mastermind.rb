# frozen_string_literal: true

require 'colorize'
require './player'

# mastermind main class
class Mastermind
  attr_reader :default_colors, :hidden_code, :code_breaker, :code_maker, :current_turn

  def initialize
    @default_colors = %w[white magenta red blue green yellow]
    @current_turn = 0
  end

  def play_mastermind
    p pick_role
    p guess_hidden_code
    p @current_turn += 1
  end

  def pick_role
    puts 'Do you want to be the codemaker (1) or codebreaker (2) ?'
    role = gets.chomp
    validate_role(role)
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

  def validate_role(role)
    case role.to_i
    when 1
      @codemaker = Player.new('maker')
    when 2
      @code_maker = Player.new('breaker')
    else
      puts 'Please enter either 1 for codemaker or 2 for codebreaker: '
      pick_role
    end
  end

  def validate_guess(guess)
    if guess.length != 4
      true
    else
      guess.split('').any? { |num| p num.to_i < 1 || num.to_i > 6 } == true
    end
  end
end
