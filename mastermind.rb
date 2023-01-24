# frozen_string_literal: true

require 'colorize'
require './player'
require './instructions'

# mastermind main class
class Mastermind
  include Instructions

  MAX_TURNS = 12

  attr_reader :default_colors, :hidden_code, :player, :computer,
              :turn, :guess, :over

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
    set_computer_role
    set_hidden_code
    system 'clear'
  end

  def play
    display_game_information
    @player.role == :codebreaker ? obtain_player_guess : obtain_computer_guess
    guess_feedback
    game_won?
    @turn += 1
  end

  private

  def obtain_player_guess
    print "\nPlease make your guess: "
    @guess = @player.guess
    obtain_player_guess if validate_player_input(@guess)
    puts "Previous guess: #{@guess}" unless @guess.nil?
  end

  def obtain_computer_guess
    @guess = []
    @computer.guess.each do |guess|
      @guess.push(@default_colors[guess])
    end
    puts "Computer guess: #{@guess}"
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
    role = gets.chomp

    case role.to_i
    when 1
      @player.role = :codemaker
    when 2
      @player.role = :codebreaker
    end

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

  def set_computer_role
    @computer.role == if @player.role == :codebreaker
                        :codemaker
                      else
                        :codebreaker
                      end
  end

  def set_hidden_code
    if @player.role == :codemaker
      print "\nPlease select which 4 colors will be the hidden code: "
      code = @player.set_hidden_code
      validate_player_input(code) ? set_hidden_code : @hidden_code = code
    else
      @hidden_code = @default_colors.dup
      @hidden_code.delete_at(rand(@hidden_code.length)) while @hidden_code.length > 4
    end
  end

  def display_game_information
    puts "\n"
    puts ['white', 'magenta'.magenta, 'red'.red, 'blue'.blue, 'green'.green, 'yellow'.yellow].join(' | ')
    puts "Current Turn: #{@turn} of 12"
  end

  def check_color_in_hidden_code
    color_exists = 0
    @guess.each { |color| color_exists += 1 if @hidden_code.join.match?(color) }
    color_exists
  end

  def check_position_in_hidden_code
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
    check_position_in_hidden_code.times { feedback.push('●') }
    (check_color_in_hidden_code - check_position_in_hidden_code).times { feedback.push('○') }
    puts feedback.join(' ').chomp('')
  end

  def game_won?
    if @guess == @hidden_code
      @over = true
      puts @player.role == :codebreaker ? 'Congrats you cracked the code!' : 'The computer cracked your code!'
    elsif @turn > MAX_TURNS
      @over = true
      puts @player.role == :codebreaker ? 'You didn\'t crack the code!' : 'The computer failed to crack your code!'
    else
      puts 'The code remains uncracked, maybe next time!'
    end
  end
end
