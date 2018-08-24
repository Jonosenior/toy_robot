module ToyRobot
  class Board
    def initialize(size)
      @size = size
    end

    def valid_location?(location)
      return false if location[0] < 0 || location[0] > @size[0]
      return false if location[1] < 0 || location[1] > @size[1]
      true
    end
  end
end
