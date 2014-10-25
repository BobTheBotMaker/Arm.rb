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
        logger.info "#{@config.name} moving to #{position}, from #{@current_position}, delta #{delta}"
        @controller.move(position)
        @current_position = @controller.get_position
      end
    end

    def move(increment)
      if increment != 0
        pos = @current_position + increment
        if check_position?(pos)
          @current_position = pos
          logger.info "#{@config.name} moving #{increment} to #{@current_position}"
          @controller.move(@current_position)
        end
      end
    end

    def check_position?(position)
      position.between?(@config.position_min, @config.position_max)
    end
    def position
      @controller.get_position
    end

    def disengage
      @controller.disengage_servo
    end

  end
end
