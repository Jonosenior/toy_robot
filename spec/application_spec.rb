require File.expand_path('../../lib/toy_robot/application', __FILE__)


RSpec.describe ToyRobot::Application do
  subject(:app) { ToyRobot::Application.new }

  before do
    allow_any_instance_of(IO).to receive(:puts)
  end

  context '#initialize' do
    it 'creates a new table' do
      expect(app.instance_variable_get('@table').class).to eq(ToyRobot::Table)
    end
  end

  context '#valid_instruction?' do
    context 'when command is invalid' do
      instruction = { command: 'PLECE' }

      it 'returns false' do
        expect(app.valid_instruction?(instruction)).to be_falsey
      end
    end

    context 'when command is PLACE' do
      it 'returns false if x co-ordinate is nil' do
        instruction = { command: 'PLACE', location: [nil, 1], facing:'SOUTH'  }
        expect(app.valid_instruction?(instruction)).to be_falsey
      end

      it 'returns false if y co-ordinate is nil' do
        instruction = { command: 'PLACE', location: [4, nil], facing:'SOUTH'  }
        expect(app.valid_instruction?(instruction)).to be_falsey
      end

      it 'returns false if facing is invalid' do
        instruction = { command: 'PLACE', location: [nil, 1], facing:'DOWN'  }
        expect(app.valid_instruction?(instruction)).to be_falsey
      end

      it 'returns true if instruction is valid' do
        instruction = { command: 'PLACE', location: [2, 3], facing: 'NORTH' }
        expect(app.valid_instruction?(instruction)).to be_truthy
      end
    end

    context 'when command is MOVE' do
      it 'returns false if robot falls off board' do
        instruction = { command: 'PLACE', location: [5, 5], facing: 'NORTH' }
        app.make_move(instruction)
        instruction = { command: 'MOVE' }
        expect(app.valid_instruction?(instruction)).to be_falsey
      end

      it 'returns false if robot not yet placed' do
        instruction = { command: 'MOVE' }
        expect(app.valid_instruction?(instruction)).to be_falsey
      end

      it 'returns true if move is valid' do
        instruction = { command: 'PLACE', location: [1, 1], facing: 'SOUTH' }
        app.make_move(instruction)
        instruction = { command: 'MOVE' }
        expect(app.valid_instruction?(instruction)).to be_truthy
      end
    end

    context 'when command is REPORT' do
      it 'returns false if robot not yet placed' do
        instruction = { command: 'REPORT' }
        expect(app.valid_instruction?(instruction)).to be_falsey
      end

      it 'returns true if robot is placed' do
        instruction = { command: 'PLACE', location: [1, 1], facing: 'SOUTH' }
        app.make_move(instruction)
        instruction = { command: 'REPORT' }
        expect(app.valid_instruction?(instruction)).to be_truthy
      end
    end

    context 'when command is EXIT' do
      it 'returns true' do
        instruction = { command: 'EXIT' }
        expect(app.valid_instruction?(instruction)).to be_truthy
      end
    end

  end

  context '#make_move' do
    context 'when command is PLACE' do

      it 'returns a robot' do
        instruction = { command: 'PLACE', location: [0, 1], facing: 'WEST' }
        expect(app.make_move(instruction)).to be_a ToyRobot::Robot
      end

      it 'saves a new robot as instance variable' do
        instruction = { command: 'PLACE', location: [0, 1], facing: 'WEST' }
        app.make_move(instruction)
        expect(app.instance_variable_get('@robot').class).to eq(ToyRobot::Robot)
      end

      it 'saves a robot with correct location' do
        instruction = { command: 'PLACE', location: [4, 5], facing: 'WEST' }
        app.make_move(instruction)
        expect(app.instance_variable_get('@robot').location).to eq(instruction[:location])
      end

      it 'saves a robot with correct facing direction' do
        instruction = { command: 'PLACE', location: [4, 5], facing: 'SOUTH' }
        app.make_move(instruction)
        expect(app.instance_variable_get('@robot').facing).to eq(instruction[:facing])
      end
    end

    context 'when command is MOVE' do
      before do
        instruction = { command: 'PLACE', location: [0, 1], facing: 'NORTH' }
        app.create_robot(instruction)
        instruction = { command: 'MOVE' }
        app.make_move(instruction)
      end

      it 'updates robot\'s location' do
        expect(app.instance_variable_get('@robot').location).to eq([0, 2])
      end

      it 'doesn\'t save previous location' do
        expect(app.instance_variable_get('@robot').location).not_to eq([0, 1])
      end
    end

    context 'when command is LEFT' do

      before do
        instruction = { command: 'PLACE', location: [0, 1], facing: 'NORTH' }
        app.create_robot(instruction)
        instruction = { command: 'LEFT' }
        app.make_move(instruction)
      end

      it 'turns robot left' do
        expect(app.instance_variable_get('@robot').facing).to eq('WEST')
      end
    end

    context 'when command is RIGHT' do

      before do
        instruction = { command: 'PLACE', location: [4, 5], facing: 'EAST' }
        app.create_robot(instruction)
        instruction = { command: 'RIGHT' }
        app.make_move(instruction)
      end

      it 'turns robot right' do
        expect(app.instance_variable_get('@robot').facing).to eq('SOUTH')
      end

    end

    context 'when command is REPORT' do
      before do
        instruction = { command: 'PLACE', location: [2, 3], facing: 'SOUTH' }
        app.create_robot(instruction)
      end

      it 'prints the robot\'s location and facing direction' do
        instruction = { command: 'REPORT' }
        expect { app.make_move(instruction) }.to output("\n2,3,SOUTH\n").to_stdout
      end
    end

    context 'when command is EXIT' do
      instruction = { command: 'EXIT' }

      it 'exits the program' do
        expect { app.make_move(instruction) }.to raise_error SystemExit
      end
    end

  end

  context '#create_robot' do
    it 'creates a robot' do
      instruction = { command: 'PLACE', location: '[0, 1]', facing: 'WEST' }
      expect(app.create_robot(instruction)).to be_a ToyRobot::Robot
    end

    it 'saves the robot as an instance variable' do
      instruction = { command: 'PLACE', location: '[0, 1]', facing: 'WEST' }
      app.create_robot(instruction)
      expect(app.instance_variable_get('@robot').class).to eq(ToyRobot::Robot)
    end
  end

  context '#elicit_input' do
    it 'returns the input' do
      input = 'REPORT'
      allow(app).to receive(:gets).and_return(input)
      expect(app.elicit_input).to eq(input)
    end

    it 'prints the elict input message' do
      message = "\n\nChoose:\nPLACE X,Y,F (e.g. 'PLACE 0,3,NORTH')\nMOVE\nLEFT\nRIGHT\nREPORT\nEXIT\n\n"
      allow(app).to receive(:gets).and_return("REPORT")
      expect { app.elicit_input }.to output(message).to_stdout
    end
  end

  context '#convert_input' do
    context 'when input is lower case' do
      it 'returns as upper case' do
        input = 'place 3,5,north'
        expected = { command: 'PLACE', location: [3, 5], facing: 'NORTH'}
        expect(app.convert_input(input)).to eq(expected)
      end
    end

    context 'when input location is not integer' do
      it 'returns location as nil' do
        input = 'PLACE a,b,SOUTH'
        expected = { command: 'PLACE', location: [nil, nil], facing: 'SOUTH'}
        expect(app.convert_input(input)).to eq(expected)
      end
    end

    context 'when input has extraneous spaces' do
      it 'returns correct result' do
        input = 'PLACE 4  , 4 ,      EAST'
        expected = { command: 'PLACE', location: [4,4], facing: 'EAST'}
        expect(app.convert_input(input)).to eq(expected)
      end
    end

  end



end
