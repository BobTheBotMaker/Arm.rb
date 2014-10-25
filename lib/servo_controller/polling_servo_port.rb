require_relative 'servo_controller'

class PollingServoPort

  def initialize(raw_servo_port)
    @servo_port = raw_servo_port
  end

  def initialize_servo(config)
    @servo_port.init_port(config)
  end

  def move_to(position)
    @servo_port.move_to(position)
    until within_tolerance(position, get_position, 0.01)
      sleep 1
    end
  end

  def move(position)
    @servo_port.move_to(position)
  end

  def disengage_servo
    @servo_port.disengage_servo
    while @servo_port.engaged?
      sleep 1
    end
  end

  def within_tolerance(required, actual, tolerance)
    difference = required - actual
    difference.abs < tolerance
  end

  def get_position
    @servo_port.get_position
  end

end
