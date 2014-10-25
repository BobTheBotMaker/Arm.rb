
class ServoArm
  include Logging

  def initialize(servo_controller, joystick_controller)
    @keep_running = true
    @servo_controller = servo_controller
    @joystick_controller = joystick_controller
    setup_joints
    setup_joystick
  end

  def setup_joints
    @shoulder_x_servo = @servo_controller.get_polling_port(0)
    @shoulder_x = Joints::Joint.new(@shoulder_x_servo)
    @shoulder_x.configure do |config|
      config.initial_position = 120
      config.position_min = 30
      config.position_max = 220
      config.acceleration = 250
      config.ramping = true
      config.type = :hitec_hs645mg
    end
    @shoulder_x.init

    @gripper = Joints::Gripper.new(@servo_controller)
    @gripper.configure do |config|
      config.port = 5
      config.initial_position = 100
      config.position_min = 30
      config.position_max = 170
      config.acceleration = 250
      config.ramping = true
      config.type = :default
    end
    @gripper.init
  end

  def setup_joystick
    @joystick_controller.on(:j1, lambda {|val| update_servo_positions(val)})
    @joystick_controller.on(:right2, lambda {|val| grip(val)})
  end

  def update_servo_positions(joystick_data)
    pos = joystick_data[:x].linear_scale
    logger.info "Original #{joystick_data[:x]} Scaled #{pos}"
    @shoulder_x.move(pos)
    #@shoulder_y.move(map(joystick_data[:y]))
  end

  def grip(val)
    val[:value] > 0 ? @gripper.close : @gripper.open
  end

  def run
    while @keep_running
      @joystick_controller.update_axes
      @joystick_controller.update_buttons
      sleep 0.5
    end
  end

  def shutdown
    @keep_running = false
    @shoulder_x.disengage
    #@shoulder_y.disengage
    @gripper.disengage
  end
end