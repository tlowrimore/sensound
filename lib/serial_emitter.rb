class SerialEmitter
  MODES = %i(read generate)

  class << self

    attr_reader :provider

    def start(mode, *args)
      unless MODES.include?(mode.to_sym)
        raise ArgumentError, "an unknown mode was specified"
      end

      send mode, *args
    end

    def subscribe(&block)
      @provider.subscribe(&block)
    end

    def unsubscribe(&block)
      @provider.unsubscribe(&block)
    end

    private

    def read(serial_port)
      @provider ||= begin
        puts "\e[35mEmitter: starting serial reader on serial port: #{serial_port}\e[0m"
        SerialReader.start(serial_port)
      end
    end

    def generate()
      @provider ||= begin
        puts "\e[35mEmitter: starting serial generator\e[0m"
        SerialGenerator.start()
      end
    end
  end
end
