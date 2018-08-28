require File.expand_path('../../lib/toy_robot/application', __FILE__)
# require File.expand_path('../../lib/toy_robot/robot', __FILE__)


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

  context '#make_move' do
    context 'when command is PLACE' do

      it 'returns a robot' do
        instruction = {command: "PLACE", location: [0,1], facing: "WEST"}
        expect(app.make_move(instruction)).to be_a ToyRobot::Robot
      end

      it 'saves a new robot as instance variable' do
        instruction = {command: "PLACE", location: [0,1], facing: "WEST"}
        app.make_move(instruction)
        expect(app.instance_variable_get('@robot').class).to eq(ToyRobot::Robot)
      end

      it 'saves a robot with correct location' do
        instruction = {command: "PLACE", location: [4,5], facing: "WEST"}
        app.make_move(instruction)
        expect(app.instance_variable_get('@robot').location).to eq(instruction[:location])
      end

      it 'saves a robot with correct facing direction' do
        instruction = {command: "PLACE", location: [4,5], facing: "SOUTH"}
        app.make_move(instruction)
        expect(app.instance_variable_get('@robot').facing).to eq(instruction[:facing])
      end
    end

    context 'when command is MOVE' do
      before do
        instruction = {command: "PLACE", location: [0,1], facing: "NORTH"}
        app.create_robot(instruction)
        instruction = {command: "MOVE"}
        app.make_move(instruction)
      end

      it 'updates robot\'s location' do
        expect(app.instance_variable_get('@robot').location).to eq([0,2])
      end

      it 'doesn\'t save previous location' do
        expect(app.instance_variable_get('@robot').location).not_to eq([0,1])
      end
    end

    context 'when command is LEFT' do

      before do
        instruction = {command: "PLACE", location: [0,1], facing: "NORTH"}
        app.create_robot(instruction)
        instruction = {command: "LEFT"}
        app.make_move(instruction)
      end

      it 'turns robot left' do
        expect(app.instance_variable_get('@robot').facing).to eq("WEST")
      end
    end

    context 'when command is RIGHT' do

      before do
        instruction = {command: "PLACE", location: [4,5], facing: "EAST"}
        app.create_robot(instruction)
        instruction = {command: "RIGHT"}
        app.make_move(instruction)
      end

      it 'turns robot right' do
        expect(app.instance_variable_get('@robot').facing).to eq("SOUTH")
      end

    end

    context 'when command is REPORT' do
      before do
        instruction = {command: "PLACE", location: [2,3], facing: "SOUTH"}
        app.create_robot(instruction)
      end

      it 'prints the robot\'s location and facing direction' do
        instruction = {command: "REPORT"}
        expect { app.make_move(instruction) }.to output("\n2,3,SOUTH\n").to_stdout

      end
    end
  end

  context '#create_robot' do
    it 'creates a robot' do
      instruction = {command: "PLACE", location: "[0,1]", facing: "WEST"}
      expect(app.create_robot(instruction)).to be_a ToyRobot::Robot
    end

    it 'saves the robot as an instance variable' do
      instruction = {command: "PLACE", location: "[0,1]", facing: "WEST"}
      app.create_robot(instruction)
      expect(app.instance_variable_get('@robot').class).to eq(ToyRobot::Robot)
    end
  end


end
