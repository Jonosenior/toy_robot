require 'pry'

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

    def new_location(current_location, facing)
      moves = { "NORTH" => [current_location[0], current_location[1] + 1],
                "EAST" => [current_location[0] + 1, current_location[1]]
              }
      # binding.pry
      moves[facing]
    end
  end
end
