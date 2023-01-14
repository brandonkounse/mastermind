# frozen_string_literal: true

require 'colorize'

# text for informting user how to play
module Instructions
  def instruction
    <<-HEREDOC
      Welcome to Mastermind! To win, you must guess the correct colors in the correct order.
      There are six available colors that can make up the hidden code. The colors
      are: 1-white 2-magenta 3-red 4-blue 5-green 6-yellow. If the hidden color is
      [white, red, blue, yellow], you would have to type in 1346 for that selection.

      Each guess made will be provided feedback on it's accuracy. A white circle will indicicate
      that a correct color was guess but in the wrong location. A black circle will indiciate that
      a correct color was guess in the right location.
    HEREDOC
  end
end
