require 'ostruct'

module Joints
  class Gripper
    include Logging

    def initialize(controller)
      @config = OpenStruct.new
      @config.initial_position = 100
      @config.position_min = 30
      @config.position_max = 170
      @config.acceleration = 250
      @config.ramping = true
      @config.type = :default
      @controller = controller
    end

    def configure
      yield @config if block_given?
    end

    def init
      logger.info "Creating Gripper with Servo Port #{@config.port}"
      @controller.initialize_servo(@config)
    end

    def go_to(position)
      logger.info "Commanded #{@config.port} to move to position #{position}"
      @controller.move(position)
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
      @controller.disengage_servo
    end

  end
end