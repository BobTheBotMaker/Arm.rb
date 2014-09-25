require_relative '../../lib/joystick/joystick'
require 'minitest/autorun'
require 'mocha/mini_test'

describe JoystickController do
  before do
    @joystick = mock()
    @receiver = mock()
    @joystick_controller = JoystickController::Controller.new(@joystick, JoystickController::PS3_CONTROLLER_MAP)
  end

  describe '#update_buttons' do
    it 'should register the select button down' do
      @joystick.stubs(:button).with(0).returns(1).then.with(anything).returns(0)
      @receiver.expects(:select_button).with(1).once()
      @joystick_controller.on(:select, lambda {|val| @receiver.select_button(val)})
      @joystick_controller.update_buttons
    end

    it 'should register the select button up' do
      @joystick.stubs(:button).with(0).returns(0).then().with(anything).returns(0)
      @receiver.expects(:select_button).with(0).once()
      @joystick_controller.on(:select, lambda {|val| @receiver.select_button(val)})
      @joystick_controller.update_buttons
    end

  end
end