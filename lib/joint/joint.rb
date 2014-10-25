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
      @controller.initialize_servo(@config)
      @current_position = @config.initial_position
    end

    def go_to(position)
      delta = (position - @current_position).abs
      if delta.to_f > 1.0
        logger.info "#{self.class} #{@config.port} moving to #{position}, from #{@current_position}, delta #{delta}"
        @controller.move(position)
        @current_position = @controller.get_position
      end
    end

    def move(increment)
      logger.info "#{self.class} position #{@current_position}"
      @current_position += increment
      logger.info "#{self.class.name} moving #{increment} to #{@current_position}"
      @controller.move(@current_position)
    end

    def position
      @controller.get_position
    end

    def disengage
      @controller.disengage_servo
    end

  end
end
