module Joints
  class Gripper
    include Logging

    def initialize(controller, port, options)
      @port = port
      @options = options
      @controller = controller
      @position = options[:initial_position]

      setup_servo
      logger.info "Created Gripper with Servo Port #{port}"
    end

    def setup_servo
      @controller.initialize_servo(@port, @options)
      @current_position = @controller.get_position(@port)
    end

    def move(position)
      delta = (position - @current_position).abs
      if delta > 1
        logger.info "Commanded #{@port} to move to position #{position}, current position #{@current_position}"
        @controller.move(@port, position)
        @current_position = position
      end
    end

    def open
      logger.info 'Gripper Open'
      move(@options[:position_min])
    end

    def close
      logger.info 'Gripper Close'
      move(@options[:position_max])
    end

    def position
      @controller.get_position(@port)
    end

    def disengage
      @controller.disengage_servo(@port)
    end

  end
end