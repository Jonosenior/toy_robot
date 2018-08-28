
module ToyRobot
  class Robot
    attr_reader :location, :facing

    def initialize(input)
      @location = input.fetch(:location)
      @facing = input.fetch(:facing)
    end

    def move_to(location)
      @location = location
    end

    def turn(left_or_right)
      turn_left = { "NORTH" => "WEST", "WEST" => "SOUTH", "SOUTH" => "EAST", "EAST" => "NORTH" }
      turn_right = { "NORTH" => "EAST", "EAST" => "SOUTH", "SOUTH" => "WEST", "WEST" => "NORTH" }
      @facing = (left_or_right == "LEFT") ? turn_left[@facing] : turn_right[@facing]
    end

    def location_and_facing
      { location: @location, facing: @facing }
    end

  end
end
