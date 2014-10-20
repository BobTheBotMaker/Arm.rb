require_relative '../../lib/joystick/joystick'
require 'minitest/autorun'

describe JoystickController::JoystickPosition do
  it 'should be able to compare positions' do
    position = JoystickController::JoystickPosition.new(50)
    position2 = JoystickController::JoystickPosition.new(50)

    (position == position2).must_equal true
  end

  it 'should be able to add two positions' do
    position = JoystickController::JoystickPosition.new(50)
    position2 = JoystickController::JoystickPosition.new(50)

    new_position = position + position2
    new_position.must_equal JoystickController::JoystickPosition.new(100)
  end

  it 'should be able to add a number to a position' do
    position = JoystickController::JoystickPosition.new(50)

    new_position = position + 10
    new_position.must_equal JoystickController::JoystickPosition.new(60)
  end

  it 'should be able to add a position to a number' do
    position = JoystickController::JoystickPosition.new(50)

    new_position = 10 + position
    new_position.must_equal JoystickController::JoystickPosition.new(60)
  end


end