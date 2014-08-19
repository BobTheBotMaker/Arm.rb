require 'rubygems'
require 'phidgets-ffi'
require_relative 'my_logger'

class ServoController
  include Logging

  def initialize
    @controller = Phidgets::AdvancedServo.new
    do_attach

    until @controller.attached?
      logger.info 'Waiting'
      sleep 10
    end
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
  end

end
