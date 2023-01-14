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
    display_game_information
    guess_hidden_code
  end

  def pick_role
    puts 'Do you want to be the codemaker (1) or codebreaker (2) ?'
    role = gets.chomp
    validate_role(role)
  end

  def guess_hidden_code
    print 'Please make your guess: '
    guess = gets.chomp
    guess_hidden_code if invalid_guess?(guess)
  end

  def display_game_information
    puts "Current Turn: #{@current_turn} of 12"
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

  def invalid_guess?(guess)
    if guess.split('').any? { |alpha| ('a'..'z').cover?(alpha) }
      puts 'Please enter only numbers!'
    elsif guess.length != 4
      puts 'Please enter 4 numbers!'
    elsif guess.split('').any? { |num| num.to_i < 1 || num.to_i > 6 } == true
      puts 'Numbers have to be 1 through 6 only!'
    end
  end
end
