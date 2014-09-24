require 'ruby-sdl-ffi'

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
  #button = SDL::JoystickGetAxis(stick, 0)
  button = SDL::JoystickGetButton(stick, 12)
  puts button

end
