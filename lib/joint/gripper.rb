require 'ostruct'

module Joints
  class Gripper
    include Logging

    def initialize(controller)
      @config = OpenStruct.new
      @controller = controller
    end

    def configure
      yield @config
    end

    def init
      logger.info "Creating Gripper with Servo Port #{@config.port}"
      @controller.initialize_servo(@config.port, @config)
    end

    def go_to(position)
      logger.info "Commanded #{@config.port} to move to position #{position}, current position #{@current_position}"
      @controller.move(@config.port, position)
    end

    def open
      logger.info 'Gripper Open'
      go_to(@config.position_min)
    end

    def close
      logger.info 'Gripper Close'
      go_to(@config.position_max)
    end

    def disengage
      @controller.disengage_servo(@config.port)
    end

  end
end