module JoystickController

  class JoystickAxis
    def initialize(axis, value)
      @stick[axis] = value
    end
  end

  class JoystickState
    def initialize
      @buttons = {}
      @axes = {}
    end

    def update_button(button, state)
      if @buttons[button] != state
        @buttons[button] = state
      end

    end

    def update_axis(stick, axis, value)
      @axes[stick] = new JoystickAxis(axis, value)
    end

  end
end