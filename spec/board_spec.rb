require File.expand_path('../../lib/toy_robot/board', __FILE__)

RSpec.describe ToyRobot::Board do
  context 'initialized as a 5 by 5 board' do
    subject(:board) { ToyRobot::Board.new([5,5]) }

    describe '#valid_location?' do
      it 'returns negative x-axis as invalid' do
        expect(board.valid_location?([-1,0])).to be_falsey
      end
    end
  end



end
