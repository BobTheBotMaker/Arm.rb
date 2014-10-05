module JoystickController

  class Controller
    def initialize(joystick, controller_map)
      @joystick = joystick
      @controller_map = controller_map
      @event_callbacks = {}
    end

    def on(event, action)
      @event_callbacks[event] = action
    end

    def update_buttons
      button_map = @controller_map[:buttons]
      button_map.each do |button, name|
        value = @joystick.button(button)
        if @event_callbacks.has_key?(name)
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