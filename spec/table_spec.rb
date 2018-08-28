require File.expand_path('../../lib/toy_robot/table', __FILE__)

RSpec.describe ToyRobot::Table do
  context 'initialized as a 5 by 5 table' do
    subject(:table) { ToyRobot::Table.new([5, 5]) }


    describe '#valid_location?' do
      it 'returns negative x-axis as invalid' do
        expect(table.valid_location?([-1, 0])).to be_falsey
      end

      it 'returns negative y-axis as invalid' do
        expect(table.valid_location?([0, -1])).to be_falsey
      end

      it 'returns too-large x-axis as invalid' do
        expect(table.valid_location?([6, 1])).to be_falsey
      end

      it 'returns too-large y-axis as invalid' do
        expect(table.valid_location?([2, 6])).to be_falsey
      end

      it 'returns valid location as valid' do
        expect(table.valid_location?([0, 0])).to be_truthy
      end
    end

    describe '#location_after_move' do
      it 'returns correct location when facing NORTH' do
        location_and_facing = { location: [0, 0], facing: 'NORTH' }
        expect(table.location_after_move(location_and_facing)).to eq([0, 1])
      end

      it 'returns correct location when facing EAST' do
        location_and_facing = { location: [0, 0], facing: 'EAST' }
        expect(table.location_after_move(location_and_facing)).to eq([1, 0])
      end

      it 'returns correct location when facing WEST' do
        location_and_facing = { location: [5, 5], facing: 'WEST' }
        expect(table.location_after_move(location_and_facing)).to eq([4, 5])
      end

      it 'returns correct location when facing SOUTH' do
        location_and_facing = { location: [3, 2], facing: 'SOUTH' }
        expect(table.location_after_move(location_and_facing)).to eq([3, 1])
      end

    end
  end



end
