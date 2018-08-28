module ToyRobot
  class Table
    def initialize(size)
      @size = size
    end

    def valid_move?(location_and_facing)
      new_location = location_after_move(location_and_facing)
      valid_location?(new_location)
    end

    def valid_location?(location)
      return false if location[0] < 0 || location[0] > @size[0]
      return false if location[1] < 0 || location[1] > @size[1]
      true
    end

    def location_after_move(current_location_facing)
      current_location = current_location_facing[:location]
      facing = current_location_facing[:facing]
      moves = { 'NORTH' => [current_location[0], current_location[1] + 1],
                'EAST' => [current_location[0] + 1, current_location[1]],
                'SOUTH' => [current_location[0], current_location[1] - 1],
                'WEST' => [current_location[0] - 1, current_location[1]],
              }
      moves[facing]
    end
  end
end
