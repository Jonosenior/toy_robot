require_relative '../lib/toy_robot/board'
require 'pry'

module ToyRobot
  class Application
    attr_reader :board

    def initialize
      @board = ToyRobot::Board.new([5,5])
    end

    def new_round
      location_and_facing = elicit_input




    end

    def convert_input(input)
      input = input.split(",")
      location_and_facing = { location => [input[0], input[1]],
                              facing => input[2]
                            }
    end

    def elicit_input
      # binding.pry
      puts "Choose:\nPLACE X,Y,F (e.g. 'PLACE 0,3,NORTH')\nMOVE\nLEFT\nRIGHT\nREPORT"
      gets.chomp
    end
  end
end

app = ToyRobot::Application.new
app.new_round
