require 'ostruct'

module Joints
  class Joint
    include Logging

    def initialize(controller)
      @config = OpenStruct.new
      @controller = controller
    end

    def configure
      yield @config
    end

    def init
      logger.info "Creating Joint with Servo Port #{@config.port}"
      @controller.initialize_servo(@config.port, @config)
      @current_position = @config.initial_position
    end

    def go_to(position)
      delta = (position - @current_position).abs
      if delta.to_f > 1.0
        logger.info "Port #{@config.port} moving to #{position}, from #{@current_position}, delta #{delta}"
        @controller.move(@config.port, position)
        @current_position = @controller.get_position(@config.port)
      end
    end

    def move(increment)
      logger.info "Port #{@config.port} position #{@current_position}"
      @current_position += increment
      logger.info "Port #{@config.port} moving #{increment} to #{@current_position}"
      @controller.move(@config.port, @current_position)
    end

    def position
      @controller.get_position(@config.port)
    end

    def disengage
      @controller.disengage_servo(@config.port)
    end

  end
end
