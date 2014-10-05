require_relative '../../lib/joystick/joystick'
require 'minitest/autorun'
require 'mocha/mini_test'

describe JoystickController do
  before do
    @joystick = mock
    @receiver = mock
    @joystick_controller = JoystickController::Controller.new(@joystick, JoystickController::PS3_CONTROLLER_MAP)
  end

  describe '#update_buttons' do
    it 'should register the select button down' do
      @joystick.stubs(:button).with(0).returns(1).then.with(anything).returns(0)
      @receiver.expects(:select_button).with({button: :select, value: 1}).once
      @joystick_controller.on(:select, lambda {|val| @receiver.select_button(val)})
      @joystick_controller.update_buttons
    end

    it 'should register the select button up' do
      @joystick.stubs(:button).with(0).returns(0).then.with(anything).returns(0)
      @receiver.expects(:select_button).with({button: :select, value: 0}).once
      @joystick_controller.on(:select, lambda {|val| @receiver.select_button(val)})
      @joystick_controller.update_buttons
    end

  end

  describe '#update_axes' do
    it 'should register a change on stick 0' do
      @joystick.stubs(:axis).with(anything).returns(0)
      @joystick.stubs(:axis).with(0).returns(795)
      @joystick.stubs(:axis).with(1).returns(895)
      @receiver.expects(:update_axis).with({stick: :j0, x: 795, y: 895}).once
      @joystick_controller.on(:j0, lambda {|val| @receiver.update_axis(val)})
      @joystick_controller.update_axes
    end

    it 'should register a change on stick 1' do
      @joystick.stubs(:axis).with(anything).returns(0)
      @joystick.stubs(:axis).with(0).returns(795)
      @joystick.stubs(:axis).with(1).returns(895)
      @receiver.expects(:update_axis).with({stick: :j1, x: 795, y: 895}).once
      @joystick_controller.on(:j1, lambda {|val| @receiver.update_axis(val)})
      @joystick_controller.update_axes
    end

  end
end