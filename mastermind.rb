# frozen_string_literal: true

require 'colorize'

# mastermind main class
class Mastermind
  attr_reader :hidden_code, :available_colors

  def initialize
    @available_colors = %w[white magenta red blue green yellow]
    set_hidden_code
  end

  private

  def set_hidden_code
    @hidden_code = @available_colors.dup
    @hidden_code.delete_at(rand(@hidden_code.length)) while @hidden_code.length > 4
  end
end
