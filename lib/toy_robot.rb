require_relative '../lib/toy_robot/table'
require_relative '../lib/toy_robot/robot'
require_relative '../lib/toy_robot/application'
require 'pry'

module ToyRobot
end

app = ToyRobot::Application.new
app.start
