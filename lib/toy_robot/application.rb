require_relative 'table'
require_relative 'robot'
require 'pry'

module ToyRobot
  class Application

    def initialize
      @table = ToyRobot::Table.new([5,5])
    end

    def start
      loop do
        input = elicit_input
        instruction = convert_input(input)
        unless valid_instruction?(instruction)
          puts 'Please give a valid instruction!'
          redo
        end
        make_move(instruction)
      end
    end

    def valid_instruction?(instruction)
      command = instruction[:command]
      return false unless possible_commands.include?(command)
      if command == 'PLACE'
        return valid_place_command?(instruction)
      else
        return false if robot_not_placed? unless command == 'EXIT'
        return false if command == 'MOVE' && falls_off_table?
      end
      true
    end

    def make_move(input)
      case input[:command]
      when 'PLACE'
        create_robot(input)
      when 'MOVE'
        move_robot
      when 'LEFT'
        @robot.turn('LEFT')
      when 'RIGHT'
        @robot.turn('RIGHT')
      when 'REPORT'
        puts report_message
      when 'EXIT'
        exit
      end
    end

    def valid_place_command?(instruction)
      return false if instruction[:location].include?(nil)
      return false unless possible_directions.include?(instruction[:facing])
      return false if !@table.valid_location?(instruction[:location])
      return true
    end

    def convert_input(input)
      input = input.split(/[\s^,]+/)
      input = { command: input[0].upcase,
                location: [number_or_nil(input[1]), number_or_nil(input[2])],
                facing: input[3]
              }
    end

    def create_robot(input)
      location = input[:location]
      facing = input[:facing]
      @robot = ToyRobot::Robot.new({location: location, facing: facing})
    end

    def move_robot
      current_location_facing = @robot.location_and_facing
      new_location = @table.location_after_move(current_location_facing)
      @robot.move_to(new_location)
    end


    def elicit_input
      puts '\n\nChoose:\nPLACE X,Y,F (e.g. "PLACE 0,3,NORTH")\nMOVE\nLEFT\nRIGHT\nREPORT\nEXIT\n\n'
      gets.chomp
    end

    def report_message
      "\n#{@robot.location[0]},#{@robot.location[1]},#{@robot.facing}\n"
    end

    def possible_directions
      %w[NORTH EAST SOUTH WEST]
    end

    def possible_commands
      %w[PLACE MOVE LEFT RIGHT REPORT EXIT]
    end

    def number_or_nil(string)
      num = string.to_i
      num if num.to_s == string
    end

    def robot_not_placed?
      !@robot
    end

    def falls_off_table?
      !@table.valid_move?(@robot.location_and_facing)
    end

  end
end
