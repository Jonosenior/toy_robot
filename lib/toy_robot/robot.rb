
module ToyRobot

  # Stores the current location and facing direction of
  # the robot, and can edit either.
  class Robot
    attr_reader :location, :facing

    def initialize(input)
      @location = input.fetch(:location)
      @facing = input.fetch(:facing)
    end

    # Changes location based on array input of form
    # [x-coordinate, y-coordinate].
    def move_to(location)
      @location = location
    end

    # Changes facing direction based on string input of either
    # 'LEFT' or 'RIGHT'.
    def turn(left_or_right)
      turn_left = { 'NORTH' => 'WEST', 'WEST' => 'SOUTH', 'SOUTH' => 'EAST', 'EAST' => 'NORTH' }
      turn_right = { 'NORTH' => 'EAST', 'EAST' => 'SOUTH', 'SOUTH' => 'WEST', 'WEST' => 'NORTH' }
      @facing = (left_or_right == 'LEFT') ? turn_left[@facing] : turn_right[@facing]
    end

    # Converts location and facing direction into a
    # convenient hash. 
    def location_and_facing
      { location: @location, facing: @facing }
    end

  end
end
