require './lib/joystick/joystick'
require './lib/servo_controller/servo_controller'
require './lib/servo_controller/polling_servo_port'
require './lib/servo_controller/servo_port'
require './lib/joint/joint'
require './lib/joint/gripper'
require './lib/servo_arm'
require 'ruby-sdl-ffi'

servo_controller = ServoController.new
servo_controller.init

joystick_hw = JoystickController::SDLJoystick.new(0)
joystick_hw.connect
joystick_controller = JoystickController::Controller.new(joystick_hw, JoystickController::PS3_CONTROLLER_MAP)

puts "Found Joystick: #{joystick_hw.firmware_name}"


servo_arm = ServoArm.new(servo_controller, joystick_controller)
servo_arm.init

Signal.trap('INT') do
  puts 'Received Shutdown command'
  servo_arm.shutdown
end

servo_arm.run

#jnt = Joint.new(psc, 0, {position_min: 30, position_max: 220, acceleration: 180, ramping: true, type: :hitec_hs645mg})

#jnt.move(40)
#jnt.move(180)
#jnt.disengage