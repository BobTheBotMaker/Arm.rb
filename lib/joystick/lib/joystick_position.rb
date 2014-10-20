module JoystickController

  class JoystickPosition
    JOYSTICK_DEAD_ZONE_UPPER = 2500
    JOYSTICK_DEAD_ZONE_LOWER = -400

    JOYSTICK_IN_MIN = -32768
    JOYSTICK_IN_MAX = 32767

    def initialize(position)
      @position = position
    end

    def map(out_min, out_max)
      pos = ((@position.to_f - JOYSTICK_IN_MIN) * (out_max - out_min) / (JOYSTICK_IN_MAX - JOYSTICK_IN_MIN) + out_min).round(2)
      JoystickPosition.new(pos)
    end

    def scale
      direction = @position < 0 ? -1 : 1
      pos = (direction)*9.5*Math.log10(direction * @position+1)
      JoystickPosition.new(pos)
    end

    def in_dead_zone?(position)
      position.between?(JOYSTICK_DEAD_ZONE_LOWER, JOYSTICK_DEAD_ZONE_UPPER)
    end

    def ==(other)
      @position == other
    end

    def coerce(other)
      [self, other]
    end

    def to_s
      "JoyStickPosition(#{@position})"
    end

    def unwrap
      @position
    end

    def method_missing(sym, *args, &block)
      args = args.map do |arg|
        (arg.respond_to? :unwrap) ? arg.unwrap : arg
      end

      result = @position.send(sym, *args, &block)
      JoystickPosition.new(result)
    end
  end

end
