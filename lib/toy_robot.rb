require_relative '../lib/toy_robot/board'
require 'pry'

module ToyRobot
  class Application
    attr_reader :board

    def initialize
      @board = ToyRobot::Board.new([5,5])
    end

    def new_round
      loop do
        input = elicit_input
        input = convert_input(input)
        binding.pry
        if !is_input_valid?(input)
          puts 'Please make a valid move!'
          redo
        end
        @robot = ToyRobot::Robot.new(input[:location], input[:facing])
      end
    end

    def is_input_valid?(input)
      command = input[:command]
      possible_commands = ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]
      return false unless possible_commands.include?(command)
      return false if !@robot && command != "PLACE"
      return false if command == "PLACE" && !@board.valid_location?(input[:location])
      return false if command == "MOVE" && !@board.valid_move?(@robot.location, @robot.facing)
      true
    end

    def convert_input(input)
      input = input.split(/[\s^,]+/)
      input = { command: input[0],
                location: [input[1], input[2]],
                facing: input[3]
              }
    end

    def elicit_input
      puts "Choose:\nPLACE X,Y,F (e.g. 'PLACE 0,3,NORTH')\nMOVE\nLEFT\nRIGHT\nREPORT"
      gets.chomp
    end
  end
end

app = ToyRobot::Application.new
app.new_round
