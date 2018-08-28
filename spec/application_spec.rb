require File.expand_path('../../lib/toy_robot/application', __FILE__)

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

  


end
