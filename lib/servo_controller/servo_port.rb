require_relative '../util/my_logger'

class ServoPort
  include Logging

  def initialize(port, controller)
    @port = port
    @controller = controller
  end

  def init_port(config)
    # Set the type first, then override all the things.
    puts "#{@controller}"
    @controller.controller.advanced_servos[@port].type = config.type
    set_acceleration(config.acceleration)
    @controller.controller.advanced_servos[@port].position_max = config.position_max
    @controller.controller.advanced_servos[@port].position_min = config.position_min
    @controller.controller.advanced_servos[@port].speed_ramping = config.ramping
    @controller.controller.advanced_servos[@port].position = config.initial_position
    engage_servo
  end

  def get_position
    position = -1
    while position < 0
      begin
        position = @controller.controller.advanced_servos[@port].position
      rescue Phidgets::Error::UnknownVal => e
        logger.info "Waiting on Servo #{@port} position"
        sleep 1
        next
      end
    end
    logger.info "Server #{@port} position is #{position}"
    position
  end

  def move_to(position)
    begin
      @controller.controller.advanced_servos[@port].position = position
    rescue Phidgets::Error::InvalidArg => e
      logger.info "Invalid move on Servo #{@port}: #{e}"
    end
  end

  def set_acceleration(acceleration)
    @controller.controller.advanced_servos[@port].acceleration = acceleration
  end

  def engaged?
    @controller.controller.advanced_servos[@port].engaged
  end

  def engage_servo
    @controller.controller.advanced_servos[@port].engaged = true
  end

  def disengage_servo
    @controller.controller.advanced_servos[@port].engaged = false
  end

end