class SerialGenerator

  VALUE_RANGE = (20..600).to_a
  FREQ        = 0.1 #seconds

  # -----------------------------------------------------
  # Class Methods
  # -----------------------------------------------------

  class << self
    attr_reader :_thread

    def subscribe(broadcaster)
      subscribers[broadcaster] = true
    end

    def unsubscribe(broadcaster)
      subscribers.delete(broadcaster)
    end

    def start
      return if _thread&.alive?

      generator = new()

      Signal.trap("INT") do
        _thread.kill
        generator.stop
      end

      @_thread = Thread.new(subscribers) do |subscribers|
        generator.read do |value|
          subscribers.each { |s,_| s.call(value) }
        end
      end

      self
    end

    private

    def subscribers
      @_subscribers ||= {}
    end
  end

  # -----------------------------------------------------
  # Instance Methods
  # -----------------------------------------------------

  def initialize
    @running = false
  end

  def read
    @running = true

    while @running
      yield VALUE_RANGE.sample
      sleep(FREQ)
    end
  end

  def stop
    @running = false
  end
end
