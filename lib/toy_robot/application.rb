require_relative 'table'
require_relative 'robot'
require 'pry'

module ToyRobot

  # The Application class directs the overall logic:
  # converting input, checking user's instruction is valid,
  # applying the instruction; and interacts with the user.
  class Application

    def initialize
      @table = ToyRobot::Table.new([5,5])
    end

    # Main application method: elicits user input,
    # converts the input to an instruction,
    # checks the instruction is valid then applies it.
    # The loop runs until user inputs 'EXIT'.
    def start
      loop do
        input = elicit_input
        instruction = convert_input(input)
        # binding.pry
        unless valid_instruction?(instruction)
          puts 'Please give a valid instruction!'
          redo
        end
        make_move(instruction)
      end
    end

    # Checks that instruction hash is valid:
    # if it includes one of the possible commands,
    # if it's a valid place command, if it requires a
    # non-existent robot and if it's a move that would fall
    # off the table.
    def valid_instruction?(instruction)
      return false if instruction.nil?
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

    # The input is a validated instruction hash, the output
    # applies that instruction.
    def make_move(instruction)
      case instruction[:command]
      when 'PLACE'
        create_robot(instruction)
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

    # Returns false if the 'PLACE' command is invalid:
    # ie, the location contains nil, the facing direction is not
    # one of the four cardinal directions, or the location
    # is off the table.
    def valid_place_command?(instruction)
      return false if instruction[:location].include?(nil)
      return false unless possible_directions.include?(instruction[:facing])
      return false if !@table.valid_location?(instruction[:location])
      return true
    end

    # Takes a string, and converts to an instruction hash
    # containing the command (eg 'PLACE', 'MOVE' etc) and
    # optionally values for location (integers converted from
    # the input string) and facing direction.
    def convert_input(input)
      input = input.split(/[\s^,]+/)
      instruction = { command: input[0].upcase,
                location: [number_or_nil(input[1]), number_or_nil(input[2])],
                facing: input[3]
              }
    end

    # Given an input hash containing location and facing,
    # it creates a robot with those attributes and saves
    # it to an instance variable.
    def create_robot(input)
      location = input[:location]
      facing = input[:facing]
      @robot = ToyRobot::Robot.new({location: location, facing: facing})
    end


    # Moves the robot one step forward by asking table
    # where the new location is then asking robot to save
    # the new location.
    def move_robot
      current_location_facing = @robot.location_and_facing
      new_location = @table.location_after_move(current_location_facing)
      @robot.move_to(new_location)
    end


    def elicit_input
      puts "\n\nChoose:\nPLACE X,Y,F (e.g. 'PLACE 0,3,NORTH')\nMOVE\nLEFT\nRIGHT\nREPORT\nEXIT\n\n"
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

    # Converts a number in the string input to an integer,
    # and returns nil if the string doesn't contain a number.
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
