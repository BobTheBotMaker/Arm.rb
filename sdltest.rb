require 'ruby-sdl-ffi'

SDL.Init(SDL::INIT_JOYSTICK)
#SDL.Init(SDL::INIT_JOYSTICK | SDL::INIT_EVENTTHREAD)
#SDL.JoystickEventState(SDL::ENABLE)
stick = SDL.JoystickOpen(0)
puts "Name #{SDL.JoystickName(0)}"

def map(x)
  in_min = -32768.to_f
  in_max = 32768.to_f
  out_min = -10.to_f
  out_max = 10.to_f

  ((x.to_f - in_min) * (out_max - out_min) / (in_max - in_min) + out_min).round(2)
end

def mapped_position(position)
  position.between?(-400, 2500) ? 0 : map(position)
end

def scale(val)
  0.01 * val**3
end

def scale2(val, direction)
  direction*9.5*Math.log10(direction*val+1)
end

while true

  direction = 1
  SDL.JoystickUpdate
  button = SDL::JoystickGetAxis(stick, 0)
  #button = SDL::JoystickGetButton(stick, 12)

  puts "X: #{button}"
  if button < 0
    direction = -1
  end
  puts "X Scaled: #{scale2(mapped_position(button), direction)}"

end
