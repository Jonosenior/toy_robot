module ToyRobot

  # Class for storing the dimensions of the table, whether
  # a location is valid (ie, if it lies on the table), and
  # whether a given 'MOVE' command is possible.
  class Table
    def initialize(size = [5, 5])
      @size = size
    end

    # Given a hash containing a location and facing direction,
    # this method returns true if moving one step forward
    # is possible (otherwise false).
    def valid_move?(location_and_facing)
      new_location = location_after_move(location_and_facing)
      valid_location?(new_location)
    end

    # Given a location as hash [x-coordinate,y-coordinate], returns
    # true if on the table and false if not.
    def valid_location?(location)
      return false if location[0] < 0 || location[0] > @size[0]
      return false if location[1] < 0 || location[1] > @size[1]
      true
    end

    # Given an input hash containing current location and facing
    # direction, returns the location after moving one unit forward.
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
