class ServoArm
  def initialize(servo_controller, joystick_controller)
    @servo_controller = servo_controller
    @joystick_controller = joystick_controller
    @joint_opts = {position_min: 30, position_max: 220, acceleration: 180, ramping: true, type: :hitec_hs645mg}
  end

  def setup_joints
    @shoulder_x = Joint.new(@servo_controller, 0, @joint_opts)
    @shoulder_y = Joint.new(@servo_controller, 0, @joint_opts)
  end

  def setup_joystick

  end

  def run

  end
end