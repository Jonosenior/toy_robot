require File.expand_path('../../lib/toy_robot/application', __FILE__)
require File.expand_path('../../lib/toy_robot/robot', __FILE__)


RSpec.describe ToyRobot::Application do
  subject(:app) { ToyRobot::Application.new }

  before do
    allow_any_instance_of(IO).to receive(:puts)
    # allow(app).to receive(:gets).and_return("Jonathan")
  end

  # context '#initialize' do
  #   it 'creates a new table' do
  #     expect(app.table).to exist
  #   end
  # end

  context '#make_move' do
    context 'when command is PLACE' do
      let(:robot) { ToyRobot::Robot.new({location: "[0,1]", facing: "EAST"}) }

      it 'creates a new robot' do
        input = {command: "PLACE", location: "[0,1]", facing: "WEST"}
        #app.make_move(input)
        app.create_robot(input)
        expect(ToyRobot::Robot).to receive(:new)
      end
    end
  end


end
