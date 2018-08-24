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
  end



end
