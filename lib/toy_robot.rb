require "toy_robot/version"

module ToyRobot
  class Robot
    def initialize(location, facing)
      @location, @facing = location, facing
    end
  end
end
