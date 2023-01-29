# frozen_string_literal: true

require './player'

# class for the computer opponent to play against
class Computer < Player
  attr_accessor :role, :feedback, :previous_guess, :all_guesses

  def initialize
    @all_guesses = []
    super
  end

  def guess(colors)
    guess = colors.sample(4)

    if evaluate_feedback == :hot
      guess = @previous_guess.shuffle
      refactor_guess(guess)
    end
    @previous_guess = guess
    @all_guesses.push(guess)
    guess
  end

  def refactor_guess(guess)
    if @all_guesses.include?(guess)
      guess.shuffle!
    else
      guess
    end
  end

  def set_role(opponent)
    @role = if opponent.role == :codebreaker
              :codemaker
            else
              :codebreaker
            end
  end

  def set_hidden_code(colors)
    colors.sample(4)
  end

  private

  def evaluate_feedback
    if @feedback.nil?
      :cold
    elsif @feedback.gsub(' ', '').length == 4
      :hot
    end
  end
end
