require File.expand_path('../../lib/toy_robot/robot', __FILE__)

RSpec.describe ToyRobot::Robot do
  subject(:robot) { ToyRobot::Robot.new({ location: [0, 0], facing: 'NORTH' }) }

  context '#initialize' do
    it 'returns the location' do
      expect(robot.location).to eq([0, 0])
    end

    it 'returns the facing direction' do
      expect(robot.facing).to eq('NORTH')
    end
  end

  context '#turn' do
    it 'can turn left from North' do
      robot.turn('LEFT')
      expect(robot.facing).to eq('WEST')
    end

    it 'can turn right from East' do
      robot.turn('RIGHT')
      expect(robot.facing).to eq('EAST')
    end
  end

  context '#move_to' do
    it 'changes to new location' do
      robot.move_to([5, 5])
      expect(robot.location).to eq([5, 5])
    end

    it 'forgets old location' do
      robot.move_to([5, 5])
      expect(robot.location).not_to eq([0, 0])
    end
  end
end
