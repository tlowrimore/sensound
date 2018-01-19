require 'serialport'

class SerialReader
  BAUD_RATE = 9600
  DATA_BITS = 8
  STOP_BITS = 1
  PARITY    = SerialPort::NONE

  class << self

    attr_reader :_thread

    # returns true when subscribed
    def subscribe(broadcaster)
      subscribers[broadcaster] = true
    end

    # returns true when unsubscribed
    def unsubscribe(broadcaster)
      subscribers.delete(broadcaster)
    end

    # starts the reader on the given serial port
    def start(serial_port)
      return if _thread&.alive?

      reader = new(serial_port)

      Signal.trap("INT") do
        _thread.kill
        reader.stop
      end

      @_thread = Thread.new(subscribers) do |subscribers|
        reader.read do |value|
          subscribers.each { |s,_| s.broadcast(value) }
        end
      end

      return self
    rescue
      puts "\e[33mWARNING: serial port could not be opened at: #{serial_port}\e[0m"
      puts "\e[33mWARNING: aborting serial reader.\e[0m"

      return false
    end

    private

    def subscribers
      @_subscribers ||= {}
    end
  end

  def initialize(serial_port)
    puts "<< Connecting to: #{serial_port} >>"

    @reader  = SerialPort.new(serial_port,
                              BAUD_RATE,
                              DATA_BITS,
                              STOP_BITS,
                              PARITY)
    @running = false
  end

  def read
    @running = true

    while @running
      yield @reader.gets.chomp
    end
  end

  def stop
    @running = false
    @reader.close()
  end
end
