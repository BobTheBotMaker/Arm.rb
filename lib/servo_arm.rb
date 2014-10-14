
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
    @shoulder_x = Joints::Joint.new(@servo_controller, 0, {initial_position: 120, position_min: 30, position_max: 220, acceleration: 250, ramping: true, type: :hitec_hs645mg})
    #@shoulder_y = Joint.new(@servo_controller, 1, {initial_position: 220, position_min: 30, position_max: 220, acceleration: 250, ramping: true, type: :hitec_hs645mg})
    @gripper = Joints::Gripper.new(@servo_controller, 5, {initial_position: 100, position_min: 30, position_max: 170, acceleration: 250, ramping: true, type: :default})
  end

  def setup_joystick
    @joystick_controller.on(:j1, lambda {|val| update_servo_positions(val)})
    @joystick_controller.on(:right2, lambda {|val| grip(val)})
  end

  def update_servo_positions(joystick_data)
    @shoulder_x.move(joystick_data[:x].map(30,220).position)
    #@shoulder_y.move(map(joystick_data[:y]))
  end

  def grip(val)
    val[:value] > 0 ? @gripper.move(170) : @gripper.move(30)
  end

  def in_dead_zone?(position)
    position.between?(-400, 2500)
  end

  def map(x)
    in_min = -32768.to_f
    in_max = 32767.to_f
    out_min = 30.to_f
    out_max = 220.to_f

    ((x.to_f - in_min) * (out_max - out_min) / (in_max - in_min) + out_min).round(2)
  end

  def mapped_position(position)
    in_dead_zone?(position) ? 120 : map(position)
  end

  def scale(val)
    direction = val < 0 ? -1 : 1
    (direction)*9.5*Math.log10(direction * val+1)
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