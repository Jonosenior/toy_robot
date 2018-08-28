require_relative 'table'
require_relative 'robot'

module ToyRobot
  class Application

    def initialize
      @table = ToyRobot::Table.new([5,5])
    end

    def new_round
      loop do
        input = elicit_input
        input = convert_input(input)
        # binding.pry
        if !is_input_valid?(input)
          puts 'Please give a valid instruction!'
          redo
        end
        make_move(input)
      end
    end

    def is_input_valid?(input)
      command = input[:command]
      return false unless possible_commands.include?(command)
      if command == "PLACE"
        return false unless possible_directions.include?(input[:facing])
        return false if !@table.valid_location?(input[:location])
        return true
      end
      return false if !@robot && command != "PLACE"
      return false if command == "MOVE" && !@table.valid_move?(@robot.location_and_facing)
      true
    end

    def make_move(input)
      case input[:command]
        when "PLACE"
          create_robot(input)
        when "MOVE"
          new_location = @table.location_after_move(@robot.location_and_facing)
          @robot.move_to(new_location)
        when "LEFT"
          @robot.turn("LEFT")
        when "RIGHT"
          @robot.turn("RIGHT")
        when "REPORT"
          puts report_message
      end
    end

    def convert_input(input)
      input = input.split(/[\s^,]+/)
      input = { command: input[0].upcase,
                location: [input[1].to_i, input[2].to_i],
                facing: input[3]
              }
    end

    def create_robot(input)
      location = input[:location]
      facing = input[:facing]
      @robot = ToyRobot::Robot.new({location: location, facing: facing})
    end

    def elicit_input
      puts "\n\nChoose:\nPLACE X,Y,F (e.g. 'PLACE 0,3,NORTH')\nMOVE\nLEFT\nRIGHT\nREPORT\n\n"
      gets.chomp
    end

    def report_message
      "\n#{@robot.location[0]},#{@robot.location[1]},#{@robot.facing}\n"
    end

    def possible_directions
      ['NORTH', 'EAST', 'SOUTH', 'WEST']
    end

    def possible_commands
      ["PLACE", "MOVE", "LEFT", "RIGHT", "REPORT"]
    end

  end
end
