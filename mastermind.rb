# frozen_string_literal: true

require 'colorize'
require './player'
require './instructions'

# mastermind main class
class Mastermind
  include Instructions

  attr_reader :default_colors, :hidden_code, :code_breaker, :code_maker,
              :current_turn, :guess

  def initialize
    @default_colors = ['white', 'magenta'.magenta, 'red'.red, 'blue'.blue, 'green'.green, 'yellow'.yellow]
    @current_turn = 0
    puts instructions
  end

  # Player interaction methods
  def game_start_setup
    pick_player_role
    set_computer_role
    @code_breaker.name == 'player' ? player_set_hidden_code : computer_set_hidden_code
  end

  def guess_hidden_code
    print 'Please make your guess: '
    @guess = gets.chomp
    guess_hidden_code if invalid_selection?(@guess)
  end

  def play_mastermind
    display_game_information
    computer_set_hidden_code
    guess_hidden_code
  end

  private

  def pick_player_role
    print 'Do you want to be the codemaker (1) or codebreaker (2)?  '
    role = gets.chomp
    validate_player_role(role)
  end

  def validate_player_role(role)
    case role.to_i
    when 1
      @code_maker = Player.new('maker', 'player')
    when 2
      @code_breaker = Player.new('breaker', 'player')
    else
      print 'Please enter either 1 for codemaker or 2 for codebreaker: '
      pick_player_role
    end
  end

  def set_computer_role
    if @code_breaker.name == 'player'
      @code_maker = Player.new('maker', 'computer')
    else
      @code_breaker = Player.new('breaker', 'computer')
    end
  end

  def computer_set_hidden_code
    @hidden_code = @default_colors.dup
    @hidden_code.delete_at(rand(@hidden_code.length)) while @hidden_code.length > 4
  end

  def player_set_hidden_code
    puts 'Please select which 4 colors will be the hidden code: '
    player_code = gets.chomp
    player_set_hidden_code if invalid_selection?(player_code)
  end

  def invalid_selection?(guess)
    if guess.split('').any? { |input| !(1..6).cover?(input.to_i) }
      puts 'Entry must be numbers 1 through 6 only!'
    elsif guess.length != 4
      puts 'Entry must be exactly four numbers!'
    end
  end

  # def display_previous_guess(guess)
  #   previous_guess = []
  #   guess.split('').each do |color|
  #     previous_guess.push(default_colors[color.to_i - 1])
  #   end
  #   previous_guess
  # end

  def display_current_turn
    "Current Turn: #{@current_turn} of 12"
  end

  def display_game_information
    puts "\n"
    puts @default_colors.join(' | ')
    puts display_current_turn
  end

  def next_turn
    @current_turn += 1
  end
end
