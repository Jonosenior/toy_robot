require File.expand_path('../../lib/toy_robot/table', __FILE__)

RSpec.describe ToyRobot::Table do
  context 'initialized as a 5 by 5 table' do
    subject(:table) { ToyRobot::Table.new([5,5]) }


    describe '#valid_location?' do
      it 'returns negative x-axis as invalid' do
        expect(table.valid_location?([-1,0])).to be_falsey
      end

      it 'returns negative y-axis as invalid' do
        expect(table.valid_location?([0,-1])).to be_falsey
      end

      it 'returns too-large x-axis as invalid' do
        expect(table.valid_location?([6,1])).to be_falsey
      end

      it 'returns too-large y-axis as invalid' do
        expect(table.valid_location?([2,6])).to be_falsey
      end

      it 'returns valid location as valid' do
        expect(table.valid_location?([0,0])).to be_truthy
      end
    end

    describe '#location_after_move' do
      it 'returns correct location when facing NORTH' do
        expect(table.location_after_move([0,0], "NORTH")).to eq([0,1])
      end

      it 'returns correct location when facing EAST' do
        expect(table.location_after_move([0,0], "EAST")).to eq([1,0])
      end

      it 'returns correct location when facing WEST' do
        expect(table.location_after_move([5,5], "WEST")).to eq([4,5])
      end

      it 'returns correct location when facing SOUTH' do
        expect(table.location_after_move([3,2], "SOUTH")).to eq([3,1])
      end

    end
  end



end
