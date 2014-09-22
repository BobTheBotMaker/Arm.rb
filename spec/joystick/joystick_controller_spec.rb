require_relative '../../lib/joystick/joystick_controller'
require_relative '../../lib/joystick/ps3_controller_map'
require 'minitest/autorun'

describe JoystickController do
  before do
    @joystick = Minitest::Mock.new
    @joystick_controller = JoystickController::Controller.new(@joystick, JoystickController::PS3_CONTROLLER_MAP)
  end

  describe '#update_buttons' do
    it 'should register the select button down' do
      @joystick.
      @joystick.expect(:button, 1, [0])
      @joystick_controller.update_buttons
      @joystick.verify
    end
  end
end