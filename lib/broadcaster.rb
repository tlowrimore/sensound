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

      def broadcasters
        @_broadcasters ||= {}
      end
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

  def call(value)
    note  = Note.new(sensor_value: value)
    # scale = Scale.new(note)

    ActionCable.server.broadcast stream_name, note.to_h
  end

  def finalize
    Registry.remove(self)
  end
end
