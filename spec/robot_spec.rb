require File.expand_path('../../lib/toy_robot/robot', __FILE__)

RSpec.describe ToyRobot::Robot do
  subject(:robot) { ToyRobot::Robot.new([0,0], 'NORTH') }

  context 'when initialized' do
    it 'returns the location' do
      expect(robot.location).to eq([0,0])
    end

    it 'returns the facing direction' do
      expect(robot.facing).to eq('NORTH')
    end
  end

  context 'when told to turn left' do
    it 'returns the new facing direction' do
      robot.turn('left')
      expect(robot.facing).to eq('WEST')
    end
  end

  context 'when told to turn right' do
    it 'returns the new facing direction' do
      robot.turn('right')
      expect(robot.facing).to eq('EAST')
    end
  end

  context 'when told to move' do
    it 'changes location' do
      robot.move_to([5,5])
      expect(robot.location).to eq([5,5])
    end
  end
end
