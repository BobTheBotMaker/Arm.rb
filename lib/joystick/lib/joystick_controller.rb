require_relative '../../util/my_logger'

module JoystickController

  class Controller
    include Logging

    def initialize(joystick, controller_map)
      @joystick = joystick
      @controller_map = controller_map
      @event_callbacks = {}
      @button_state = []
    end

    def on(event, action)
      @event_callbacks[event] = action
    end

    def update_buttons
      @joystick.update
      @controller_map[:buttons].each do |button, name|
        emit = true
        value = @joystick.button(button)
        if value == 0 && @button_state[button] == 0
          emit = false
        end
        @button_state[button] = value
        if emit && @event_callbacks.has_key?(name)
          @event_callbacks[name].call({button: name, value: value})
        end
      end
    end

    def update_axes
      @joystick.update
      sticks = @controller_map[:joysticks]
      sticks.each do | stick, axes |
        x = @joystick.axis(axes[:x])
        y = @joystick.axis(axes[:y])
        if @event_callbacks.has_key?(stick)
          @event_callbacks[stick].call({stick: stick, x: x, y: y})
        end
      end
    end
  end

end