# frozen_string_literal: true

require 'colorize'
require './player'
require './instructions'
require 'pry-byebug'

# mastermind main class
class Mastermind
  include Instructions

  attr_reader :default_colors, :hidden_code, :player, :computer,
              :current_turn, :guess

  def initialize
    @default_colors = ['white', 'magenta'.magenta, 'red'.red, 'blue'.blue, 'green'.green, 'yellow'.yellow]
    @hidden_code = []
    @current_turn = 0
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
    @guess = gets.chomp.split(' ')
    invalid_selection?(@guess) ? guess_hidden_code : next_turn
  end

  def play_mastermind
    display_game_information
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
                  Player.new('breaker')
                end
  end

  def invalid_selection?(guess)
    if guess.any? { |w| w.match?(/[^A-Za-z]/) } ||
       guess.any? { |w| !@default_colors.join.include?(w) } ||
       guess.uniq.count <= 3 ||
       guess.length != 4
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

  def display_current_turn
    "Current Turn: #{@current_turn} of 12"
  end

  def display_game_information
    puts "\n"
    puts @default_colors.join(' | ')
    puts @hidden_code.join(' | ')
    puts display_current_turn
  end

  def next_turn
    @current_turn += 1
  end
end
