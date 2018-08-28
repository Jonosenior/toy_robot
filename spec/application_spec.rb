require File.expand_path('../../lib/toy_robot/application', __FILE__)
require File.expand_path('../../lib/toy_robot/robot', __FILE__)


RSpec.describe ToyRobot::Application do
  subject(:app) { ToyRobot::Application.new }

  before do
    allow_any_instance_of(IO).to receive(:puts)
    # allow(app).to receive(:gets).and_return("Jonathan")
  end

  context '#initialize' do
    it 'creates a new table' do
      expect(app.instance_variable_get('@table').class).to eq(ToyRobot::Table)
    end
  end

  # context '#make_move' do
  #   context 'when command is PLACE' do
  #
  #     it 'creates a new robot' do
  #       input = {command: "PLACE", location: "[0,1]", facing: "WEST"}
  #       app.make_move(input)
  #       expect(app).to receive(:create_robot).with(input)
  #     end
  #   end
  # end

  context '#create_robot' do
    it 'creates a robot' do
      input = {command: "PLACE", location: "[0,1]", facing: "WEST"}
      expect(app.create_robot(input)).to be_a ToyRobot::Robot
    end
  end


end
