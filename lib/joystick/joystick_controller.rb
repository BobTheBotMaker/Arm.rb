require_relative 'joystick_state'

module JoystickController
  class Controller
    def initialize(joystick, controller_map)
      @joystick = joystick
      @controller_map = controller_map
      @joystick_state = JoystickState.new
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
          @joystick_state.update_axis(stick, name, val)
        end
      end
    end

    def poll
      while true
        @joystick.update
        update_axes
        update_buttons

      end
    end

  end
end