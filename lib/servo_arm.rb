require_relative 'joint/joint'

class ServoArm
  def initialize(servo_controller, joystick_controller)
    @servo_controller = servo_controller
    @joystick_controller = joystick_controller
    @joint_opts = {position_min: 30, position_max: 220, acceleration: 180, ramping: true, type: :hitec_hs645mg}
    setup_joints
    setup_joystick
  end

  def setup_joints
    @shoulder_x = Joint.new(@servo_controller, 0, @joint_opts)
    #@shoulder_y = Joint.new(@servo_controller, 1, @joint_opts)
  end

  def setup_joystick
    @joystick_controller.on(:j1, lambda {|val| update_servo_positions(val)})
  end

  def update_servo_positions(joystick_data)
    puts "#{joystick_data[:stick]}  #{map(joystick_data[:x])} #{map(joystick_data[:y])}"
    @shoulder_x.move(map(joystick_data[:x]))
  end

  def map(x)
    in_min = -32768.to_f
    in_max = 32768.to_f
    out_min = 215.to_f
    out_max = 35.to_f

    ((x.to_f - in_min) * (out_max - out_min) / (in_max - in_min) + out_min).round(2)
  end

  def run
    while true
      @joystick_controller.update_axes
    end
  end
end