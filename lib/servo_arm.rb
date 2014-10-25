
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
    @shoulder_x.init

    @elbow_servo = @servo_controller.get_polling_port(2)
    @elbow = Joints::Joint.new(@elbow_servo)
    @elbow.init

    @gripper_servo = @servo_controller.get_polling_port(5)
    @gripper = Joints::Gripper.new(@gripper_servo)
    @gripper.init
  end

  def setup_joystick
    @joystick_controller.on(:j1, lambda {|val| update_servo_positions(val)})
    @joystick_controller.on(:j0, lambda {|val| update_servo_positions(val)})
    @joystick_controller.on(:right2, lambda {|val| grip(val)})
  end

  def update_servo_positions(joystick_data)
    case joystick_data[:stick]
      when :j1
        @shoulder_x.move(joystick_data[:x].linear_scale)
      when :j0
        @elbow.move(joystick_data[:y].linear_scale)
    end
  end

  def grip(val)
    val[:value] > 0 ? @gripper.close : @gripper.open
  end

  def run
    while @keep_running
      @joystick_controller.update_axes
      @joystick_controller.update_buttons
      sleep 0.1
    end
  end

  def shutdown
    @keep_running = false
    @shoulder_x.disengage
    @elbow.disengage
    #@shoulder_y.disengage
    @gripper.disengage
  end
end