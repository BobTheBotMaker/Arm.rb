require_relative '../../lib/joystick/joystick'
require 'minitest/autorun'
require 'mocha/mini_test'

describe JoystickController do
  before do
    @joystick = mock()
    @joystick_state = JoystickController::JoystickState.new
    @joystick_controller = JoystickController::Controller.new(@joystick, @joystick_state, JoystickController::PS3_CONTROLLER_MAP)
  end

  describe '#update_buttons' do
    it 'should register the select button down' do
      @joystick.stubs(:button)
      @joystick.stubs(:button).with(0).returns(1).once()
      @joystick_controller.update_buttons
      @joystick_state.
    end

    it 'should register the select button up' do
      @joystick.stubs(:button)
      @joystick.stubs(:button).with(0).returns(0).once()
      @joystick_controller.update_buttons
    end

  end
end