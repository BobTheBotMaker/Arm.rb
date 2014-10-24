require_relative 'servo_controller'

class PollingServoController

  def initialize(servo_controller)
    @servo_controller = servo_controller
  end

  def initialize_servo(port, config)
    @servo_controller.initialize_servo(port, config)
  end

  def move_to(servo, position)
    @servo_controller.move_to(servo, position)
    until within_tolerance(position, get_position(servo), 0.01)
      sleep 1
    end
  end

  def move(servo, position)
    @servo_controller.move_to(servo, position)
  end

  def disengage_servo(servo)
    @servo_controller.disengage_servo(servo)
    while @servo_controller.engaged?(servo)
      sleep 1
    end
  end

  def within_tolerance(required, actual, tolerance)
    difference = required - actual
    difference.abs < tolerance
  end

  def get_position(servo)
    @servo_controller.get_position(servo)
  end

end
