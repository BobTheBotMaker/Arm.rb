require_relative 'servo_controller'

class Joint
  include Logging

  def initialize(controller, port, options)
    @port = port
    @options = options
    @controller = controller
    setup_servo
    logger.info "Created Joint with Servo Port #{port}"
  end

  def setup_servo
    @controller.initialize_servo(@port, @options)
  end

  def move(position)
    logger.info "Commanded #{@port} to move to position #{position}"
    @controller.move_to(@port, position)
  end

  def position
    @controller.get_position(@port)
  end

  def disengage
    @controller.disengage_servo(@port)
  end

end
