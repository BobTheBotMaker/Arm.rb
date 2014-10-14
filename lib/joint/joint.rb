module Joints
  class Joint
    include Logging

    def initialize(controller, port, options)
      @port = port
      @options = options
      @controller = controller
      @position = options[:initial_position]

      setup_servo
      logger.info "Created Joint with Servo Port #{port}"
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

    def increment_move(increment)
      logger.info "Old position #{@position}"
      @position += increment
      logger.info "Commanded #{@port} to move #{increment}, new position #{@position}"
      @controller.move(@port, @position)
    end

    def position
      @controller.get_position(@port)
    end

    def disengage
      @controller.disengage_servo(@port)
    end

  end
end
