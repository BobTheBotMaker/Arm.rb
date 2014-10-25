require 'ostruct'

module Joints
  class Joint
    include Logging

    def initialize(controller)
      @config = OpenStruct.new
      @config.initial_position = 120
      @config.position_min = 30
      @config.position_max = 220
      @config.acceleration = 250
      @config.ramping = true
      @config.type = :default

      @controller = controller
    end

    def configure
      yield @config if block_given?
    end

    def init
      logger.info "Creating #{@config.name}"
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
