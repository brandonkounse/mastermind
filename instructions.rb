# frozen_string_literal: true

require 'colorize'

# text for informting user how to play
module Instructions
  def instructions
    <<~HEREDOC
      Welcome to Mastermind!

      To win, you must guess the correct colors in the correct order. There are six available colors
      that can make up the hidden code: 1-white \e[35m2-magenta\e[0m \e[31m3-red\e[0m \e[34m4-blue\e[0m \e[32m5-green\e[0m \e[33myellow\e[0m.

      If the hidden color is [white, \e[31mred\e[0m, \e[34mblue\e[0m, \e[33myellow\e[0m], you would have to type in 1346 for that selection.

      Each guess made will be provided feedback on it's accuracy. A white circle will indiciate that
      a correct color was guessed in the right location. An empty circle will indicicate
      that a correct color was guessed but in the wrong location.

      For example, if we use the hidden code above [white, \e[31mred\e[0m, \e[34mblue\e[0m, \e[33myellow\e[0m]
      and we guessed 3145, we would see this result: ● ○ ○

      The order of the feedback circles will not correspond to their location of the colors.\n
    HEREDOC
  end
end
