require_relative 'joystick_state'

module JoystickController

  class Controller
    def initialize(joystick, state, controller_map)
      @joystick = joystick
      @controller_map = controller_map
      @joystick_state = state
      @event_callbacks = {}
    end

    def on(event, action)
      @event_callbacks[event] = action
    end

    def update_buttons
      button_map = @controller_map[:buttons]
      button_map.each do |button, name|
        val = @joystick.button(button)
        @joystick_state.update_button(name, val)
      end
    end

    def update_axes
      axis_map = @controller_map[:joysticks]
      axis_map.each do | stick |
        axis_map[stick].each do |axis, name|
          val = @joystick.axis(axis)
          if @joystick_state.update_axis(stick, name, val)
            @event_callbacks[]
          end
        end
      end
    end

    def poll
      while true
        update
      end
    end
  end

end