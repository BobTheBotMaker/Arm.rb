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

  def get_raw_port(port)
    ServoPort.new(port, self)
  end

  def get_polling_port(port)
    PollingServoPort.new(get_raw_port(port))
  end

end
