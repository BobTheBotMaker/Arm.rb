require './lib/servo_controller/servo_controller'
require './lib/servo_controller/polling_servo_controller'
require './lib/joint/joint'
require 'ruby-sdl-ffi'

servo_controller = ServoController.new
polling_servo_controller = PollingServoController.new(servo_controller)

joystick_hw = JoystickController::Joystick.new(0)
joystick_controller = JoystickController::Controller.new(joystick_hw, JoystickController::PS3_CONTROLLER_MAP)

servo_arm = ServoArm.new(polling_servo_controller, joystick_controller)
servo_arm.run




#jnt = Joint.new(psc, 0, {position_min: 30, position_max: 220, acceleration: 180, ramping: true, type: :hitec_hs645mg})

SDL.Init(SDL::INIT_JOYSTICK | SDL::INIT_EVENTTHREAD)
SDL.JoystickEventState(SDL::ENABLE)
stick = SDL.JoystickOpen(0)
puts "Name #{SDL.JoystickName(0)}"

def map(x)
  in_min = -32768.to_f
  in_max = 32768.to_f
  out_min = -1.to_f
  out_max = 1.to_f

  ((x.to_f - in_min) * (out_max - out_min) / (in_max - in_min) + out_min).round(2)
end

while true

  SDL.JoystickUpdate
  button = SDL::JoystickGetAxis(stick, 0)
  puts map(button)

end

#jnt.move(40)
#jnt.move(180)
#jnt.disengage