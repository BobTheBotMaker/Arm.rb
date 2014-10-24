require_relative '../../util/my_logger'

module JoystickController

  class JoystickPosition
    include Logging

    JOYSTICK_DEAD_ZONE_UPPER = 2500
    JOYSTICK_DEAD_ZONE_LOWER = -400

    JOYSTICK_IN_MIN = -32768
    JOYSTICK_IN_MAX = 32767

    def initialize(position)
      @position = position
    end

    def map(out_min, out_max)
      pos = in_dead_zone? ? 0 : @position
      ((pos.to_f - JOYSTICK_IN_MIN) * (out_max - out_min) / (JOYSTICK_IN_MAX - JOYSTICK_IN_MIN) + out_min).round(2)
    end

    def linear_scale
      0.2 * map(-100,100)
    end

    def log_scale
      direction = @position < 0 ? -1 : 1
      (direction)*9.5*Math.log10(direction * map(-10,10)+1)
    end

    def in_dead_zone?
      @position.between?(JOYSTICK_DEAD_ZONE_LOWER, JOYSTICK_DEAD_ZONE_UPPER)
    end
  end

end
