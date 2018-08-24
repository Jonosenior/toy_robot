require File.expand_path("../../lib/toy_robot", __FILE__)

RSpec.describe ToyRobot::Robot do
  context 'when initialized' do
    subject(:robot) { ToyRobot::Robot.new([0,0], "NORTH") }

    it 'returns the location' do
      expect(robot.location).to eq([0,0])
    end
  end
end
