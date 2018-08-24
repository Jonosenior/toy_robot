require "toy_robot/version"

module ToyRobot
  class Robot
    attr_reader :location, :facing

    def initialize(location, facing)
      @location, @facing = location, facing
    end
  end
end
