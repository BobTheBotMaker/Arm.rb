module JoystickController

  class JoystickState
    def initialize
      @buttons = {}
      @sticks = {}
    end

    def update_button(button, value)
      @buttons[button] = value
    end

    def update_axis(stick, axis, value)
      changed = false
      if  @sticks[stick][axis].value != value
        changed = true
      end
      @sticks[stick][axis] = value
      changed
    end
  end

end