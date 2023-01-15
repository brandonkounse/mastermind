# frozen_string_literal: true

# text for informting user how to play
module Instructions
  def instructions
    <<~HEREDOC
      \nWelcome to Mastermind!

      To win, you must guess the correct colors in the correct order. There are six available colors
      that can make up the hidden code: 1-white \e[35m2-magenta\e[0m \e[31m3-red\e[0m \e[34m4-blue\e[0m \e[32m5-green\e[0m \e[33m6-yellow\e[0m.

      If the hidden code is: white | \e[31mred\e[0m | \e[34mblue\e[0m | \e[33myellow\e[0m you would have to type in
      each color in the right order. Example: "white" "red" "blue" "yellow".

      Each guess will be provided feedback on it's accuracy.
      ●  means a correct color was guessed in the right location.
      ○  means a correct color was guessed, but in the wrong location.
      The order of the feedback circles **DO NOT** correspond to their location in the hidden code.

      For example, in the previous hidden code: white | \e[31mred\e[0m | \e[34mblue\e[0m | \e[33myellow\e[0m
      if we guessed \e[31mred\e[0m | white | \e[34mblue\e[0m | \e[32mgreen\e[0m we would see this result: ● ○ ○\n
    HEREDOC
  end
end
