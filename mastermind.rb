# frozen_string_literal: true

require 'colorize'
require './player'
require './instructions'

# mastermind main class
class Mastermind
  include Instructions

  attr_reader :default_colors, :hidden_code, :player, :computer,
              :turn, :guess, :game_over

  def initialize
    @default_colors = %w[white magenta red blue green yellow]
    @hidden_code = []
    @turn = 0
    @game_over = false
  end

  # Player interaction methods
  def game_start_setup
    puts instructions
    pick_player_role
    set_computer_role
    @player.role == 'codemaker' ? player_set_hidden_code : computer_set_hidden_code
  end

  def guess_hidden_code
    print "\nPlease make your guess: "
    @guess = gets.chomp.downcase.split(' ')
    invalid_selection?(@guess) ? guess_hidden_code : next_turn
  end

  def play_mastermind
    display_game_information
    guess_hidden_code
    guess_feedback
    game_won?
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
      @player = Player.new('codemaker')
    when 2
      @player = Player.new('codebreaker')
    else
      print 'Please enter either 1 for codemaker or 2 for codebreaker: '
      pick_player_role
    end
  end

  def set_computer_role
    @computer = if @player.role == 'codebreaker'
                  Player.new('codemaker')
                else
                  Player.new('codebreaker')
                end
  end

  def invalid_selection?(entry)
    if entry.any? { |w| w.match?(/[^A-Za-z]/) } ||
       entry.any? { |w| !@default_colors.join.include?(w) } ||
       entry.uniq.count <= 3 ||
       entry.length != 4
      puts 'Entry must be four seperate colors follow by a space and consist of: '.yellow
      puts "white, \e[35mmagenta\e[0m, \e[31mred\e[0m, \e[34mblue\e[0m, \e[32mgreen\e[0m or \e[33myellow\e[0m!\n"
      true
    else
      false
    end
  end

  def player_set_hidden_code
    print "\nPlease select which 4 colors will be the hidden code: "
    player_code = gets.chomp.split(' ')
    invalid_selection?(player_code) ? player_set_hidden_code : @hidden_code = player_code
  end

  def computer_set_hidden_code
    @hidden_code = @default_colors.dup
    @hidden_code.delete_at(rand(@hidden_code.length)) while @hidden_code.length > 4
  end

  def display_turn
    "Current Turn: #{@turn} of 12"
  end

  def display_game_information
    puts "\n"
    puts ['white', 'magenta'.magenta, 'red'.red, 'blue'.blue, 'green'.green, 'yellow'.yellow].join(' | ')
    puts display_turn
  end

  def next_turn
    @turn += 1
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
      @game_over = true
      puts @player.role == 'codebreaker' ? 'Congrats you cracked the code!' : 'The computer cracked your code!'
    elsif @turn >= 12
      @game_over = true
      puts @player.role == 'codebreaker' ? 'You didn\'t crack the code!' : 'The computer failed to crack your code!'
    end
  end
end
