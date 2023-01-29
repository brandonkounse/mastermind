# frozen_string_literal: true

require 'colorize'
require './instructions'

# mastermind main class
class Mastermind
  include Instructions

  MAX_TURNS = 12

  attr_reader :default_colors, :hidden_code, :player, :computer,
              :turn, :guess, :over, :feedback

  def initialize
    @default_colors = %w[white magenta red blue green yellow]
    @hidden_code = []
    @turn = 1
    @over = false
  end

  # Player interaction methods
  def add_player(player)
    if !@player.nil?
      puts 'Player already added, can\'t play with more than one player!'
    else
      @player = player
    end
  end

  def add_opponent(computer)
    @computer = computer
  end

  def setup
    puts instructions
    obtain_player_role
    obtain_computer_role
    get_hidden_code(@default_colors)
    system 'clear'
  end

  def play
    display_stats
    @player.role == :codebreaker ? obtain_player_guess : obtain_computer_guess(@default_colors)
    guess_feedback
    @turn += 1
  end

  def won?
    if @guess == @hidden_code
      @over = true
      display_stats
      puts @player.role == :codebreaker ? "\nCongrats you cracked the code!" : "\nThe computer cracked your code!"
    elsif @turn > MAX_TURNS
      @over = true
      puts @player.role == :codebreaker ? "\nYou didn't crack the code!" : "\nThe computer failed to crack your code!"
    end
  end

  private

  def obtain_player_guess
    print "\nPlease make your guess: "
    @guess = @player.guess
    obtain_player_guess if validate_player_input(@guess)
  end

  def obtain_computer_guess(colors)
    @guess = @computer.guess(colors)
  end

  def validate_player_input(input)
    if input.any? { |w| w.match?(/[^A-Za-z]/) } ||
       input.any? { |w| !@default_colors.join.include?(w) } ||
       input.uniq.count <= 3 ||
       input.length != 4
      puts 'Entry must be four seperate colors follow by a space and consist of: '.yellow
      puts "white, \e[35mmagenta\e[0m, \e[31mred\e[0m, \e[34mblue\e[0m, \e[32mgreen\e[0m or \e[33myellow\e[0m!\n"
      true
    else
      false
    end
  end

  def obtain_player_role
    print 'Do you want to be the codemaker (1) or codebreaker (2)?  '
    @player.set_role
    obtain_player_role until validate_player_role
  end

  def validate_player_role
    if @player.role == :codemaker || @player.role == :codebreaker
      true
    else
      puts 'Input for player role (codemaker or codebreaker) is not valid, please try again!'
      false
    end
  end

  def obtain_computer_role
    @computer.set_role(@player)
  end

  def get_hidden_code(colors)
    if @player.role == :codemaker
      print "\nPlease select which 4 colors will be the hidden code: "
      code = @player.guess
      validate_player_input(code) ? get_hidden_code(colors) : @hidden_code = code
    else
      @hidden_code = @computer.set_hidden_code(colors)
    end
  end

  def display_stats
    puts ["\nwhite", 'magenta'.magenta, 'red'.red, 'blue'.blue, 'green'.green, 'yellow'.yellow].join(' | ')
    puts "Current Turn: #{@turn} of 12"
    puts "Previous guess: #{@guess}" unless @guess.nil?
    puts @feedback
  end

  def check_color
    color_exists = 0
    @guess.each { |color| color_exists += 1 if @hidden_code.join.match?(color) }
    color_exists
  end

  def check_position
    correct_position = 0
    counter = 0
    while counter < @hidden_code.length
      correct_position += 1 if @guess[counter].include?(@hidden_code[counter])
      counter += 1
    end
    correct_position
  end

  def guess_feedback
    feedback = []
    check_position.times { feedback.push('●') }
    (check_color - check_position).times { feedback.push('○') }
    @feedback = feedback.join(' ').chomp('')
    @computer.feedback = @feedback if @computer.role == :codebreaker
  end
end
