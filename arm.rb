require './lib/joystick/joystick'
require './lib/servo_controller/servo_controller'
require './lib/servo_controller/polling_servo_controller'
require './lib/joint/joint'
require 'ruby-sdl-ffi'

servo_controller = ServoController.new
polling_servo_controller = PollingServoController.new(servo_controller)

joystick_state = JoystickController::JoystickState.new
joystick_hw = JoystickController::Joystick.new(0)
joystick_controller = JoystickController::Controller.new(joystick_hw, joystick_state, JoystickController::PS3_CONTROLLER_MAP)

servo_arm = ServoArm.new(polling_servo_controller, joystick_controller)
servo_arm.run

#jnt = Joint.new(psc, 0, {position_min: 30, position_max: 220, acceleration: 180, ramping: true, type: :hitec_hs645mg})

#jnt.move(40)
#jnt.move(180)
#jnt.disengage