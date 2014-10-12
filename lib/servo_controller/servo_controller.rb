require 'rubygems'
require 'phidgets-ffi'
require_relative '../util/my_logger'

class ServoController
  include Logging

  def initialize
    @controller = Phidgets::AdvancedServo.new
    setup_error_handler
    do_attach
  end

  def do_shutdown
    @controller.close
  end

  def do_attach
    @controller.on_attach  do |device|
      logger.info "Device attributes: #{device.attributes} attached"
      logger.info "Class: #{device.device_class}"
      logger.info "Id: #{device.id}"
      logger.info "Serial number: #{device.serial_number}"
      logger.info "Version: #{device.version}"
      logger.info "# Servos: #{device.advanced_servos.size}"
    end

    until @controller.attached?
      logger.info 'Waiting'
      sleep 1
    end

  end

  def setup_error_handler
    @controller.on_error do |device, obj, code, description|
      logger.info "Error #{code}: #{description}"
    end
  end

  def initialize_servo(servo, options)
    # Set the type first, then override all the things.
    @controller.advanced_servos[servo].type = options[:type]
    set_acceleration(servo, options[:acceleration])
    @controller.advanced_servos[servo].position_max = options[:position_max]
    @controller.advanced_servos[servo].position_min = options[:position_min]
    @controller.advanced_servos[servo].speed_ramping = options[:ramping]
    @controller.advanced_servos[servo].position = options[:initial_position]
    engage_servo(servo)
  end

  def get_position(servo)
    position = -1
    while position < 0
      begin
        position = @controller.advanced_servos[servo].position
      rescue Phidgets::Error::UnknownVal => e
        logger.info "Waiting on Servo #{servo} position"
        sleep 1
        next
      end
    end
    logger.info "Server #{servo} position is #{position}"
    position
  end

  def move_to(servo, position)
    begin
      @controller.advanced_servos[servo].position = position
    rescue Phidgets::Error::InvalidArg => e
      logger.info "Invalid move on Servo #{servo}: #{e}"
    end
  end

  def set_acceleration(servo, acceleration)
    @controller.advanced_servos[servo].acceleration = acceleration
  end

  def engaged?(servo)
    @controller.advanced_servos[servo].engaged
  end

  def engage_servo(servo)
    @controller.advanced_servos[servo].engaged = true
  end

  def disengage_servo(servo)
    @controller.advanced_servos[servo].engaged = false
  end

end
