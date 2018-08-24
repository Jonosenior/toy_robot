require File.expand_path('../../lib/toy_robot/board', __FILE__)

RSpec.describe ToyRobot::Board do
  context 'initialized as a 5 by 5 board' do
    subject(:board) { ToyRobot::Board.new([5,5]) }

    describe '#valid_location?' do
      it 'returns negative x-axis as invalid' do
        expect(board.valid_location?([-1,0])).to be_falsey
      end

      it 'returns negative y-axis as invalid' do
        expect(board.valid_location?([0,-1])).to be_falsey
      end

      it 'returns too-large x-axis as invalid' do
        expect(board.valid_location?([6,1])).to be_falsey
      end

      it 'returns too-large y-axis as invalid' do
        expect(board.valid_location?([2,6])).to be_falsey
      end

      it 'returns valid location as valid' do
        expect(board.valid_location?([0,0])).to be_truthy
      end
    end

    describe '#new_location' do
      it 'returns correct location when facing NORTH' do
        expect(board.new_location([0,0], "NORTH")).to eq([0,1])
      end

      it 'returns correct location when facing EAST' do
        expect(board.new_location([0,0], "EAST")).to eq([1,0])
      end

      it 'returns correct location when facing WEST' do
        expect(board.new_location([5,5], "WEST")).to eq([4,5])
      end

      it 'returns correct location when facing SOUTH' do
        expect(board.new_location([3,2], "SOUTH")).to eq([3,1])
      end

    end
  end



end
