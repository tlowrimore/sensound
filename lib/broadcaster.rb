class Broadcaster
  SEED_RANGE = 88

  # -----------------------------------------------------
  # Broadcaster Registry
  # -----------------------------------------------------

  # Used to keep track of all active broadcasters
  class Registry
    class << self

      def add(broadcaster)
        broadcasters[broadcaster] = true
      end

      def remove(broadcaster)
        broadcasters.delete(broadcaster)
      end

      def each
        broadcasters.keys.each { |b| yield b }
      end

      def broadcasters
        @_broadcasters ||= {}
      end
    end
  end

  # -----------------------------------------------------
  # Class Methods
  # -----------------------------------------------------

  class << self
    include Enumerable
    
    def each(&block)
      Registry.each(&block)
    end
  end

  # -----------------------------------------------------
  # Instance Methods
  # -----------------------------------------------------

  attr_reader :stream_name, :seed

  def initialize(stream_name)
    @stream_name  = stream_name
    @seed         = rand(SEED_RANGE)

    Registry.add(self)
  end

  def broadcast(note)
    raise NotImplementedError,
          "Broadcaster must be subclassed to implement #broadcast"
  end

  def finalize
    Registry.remove(self)
  end
end
