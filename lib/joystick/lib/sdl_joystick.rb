# Based on https://github.com/hybridgroup/artoo-joystick/blob/master/lib/artoo/adaptors/joystick.rb

require 'ruby-sdl-ffi' unless defined?(SDL)

module JoystickController
  class SDLJoystick

    def initialize(index)
      @index = index
    end

    def connect
      SDL.Init(SDL::INIT_JOYSTICK)
      raise 'No SDL joystick available' if num_joysticks == 0
      @joystick = SDL.JoystickOpen(@index)
    end

    def disconnect
      SDL.JoystickClose(@joystick)
    end

    def firmware_name
      SDL.JoystickName(@index)
    end

    def update
      SDL.JoystickUpdate
    end

    def num_joysticks
      SDL.NumJoysticks
    end

    def num_axes
      SDL.JoystickNumAxes(@joystick)
    end

    def axis(n)
      SDL.JoystickGetAxis(@joystick, n)
    end

    def num_balls
      SDL.JoystickNumBalls(@joystick)
    end

    def ball(n)
      SDL.JoystickGetBall(@joystick, n)
    end

    def num_hats
      SDL.JoystickNumHats(@joystick)
    end

    def hat(n)
      SDL.JoystickGetHat(@joystick, n)
    end

    def num_buttons
      SDL.JoystickNumButtons(@joystick)
    end

    def button(n)
      SDL.JoystickGetButton(@joystick, n)
    end
  end
end
