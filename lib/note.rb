class Note
  # Number of tones in an octave
  N_TONES     = 12

  # Lowest A on a piano
  A0          = 27.5

  # 12th root of 2
  BETA        = 2.0 ** (1.0 / N_TONES)

  # Range of sensor values
  RANGE_IN    = [20, 600]

  # Range of keys
  RANGE_OUT   = [0, 87]

  # Size of key range
  RANGE_SIZE  = 88

  # -----------------------------------------------------
  # Class Methods
  # -----------------------------------------------------

  class << self
    def create_from_sensor(sensor_value)
      index = calculate_index(sensor_value)
      new(index)
    end

    private

    def calculate_index(sensor_value)
      (RANGE_OUT.max - RANGE_OUT.min) * (sensor_value - RANGE_IN.min) / (RANGE_IN.max - RANGE_IN.min)
    end
  end

  # -----------------------------------------------------
  # Instance Methods
  # -----------------------------------------------------

  attr_reader :index

  def initialize(index=nil)
    if index.nil?
      raise ArgumentError,
            "An index must be supplied to constructor"
    end

    @index = index
  end

  def step(interval=1)
    i = (index + interval) % RANGE_SIZE
    Note.new(i)
  end

  # Returns a new note representing the current note shifted into the provided
  # octave
  def shift(to_octave)
    i = octave_index + (to_octave * N_TONES)
    Note.new(i)
  end

  # Returns the octave of the note, where 0 is the first octave
  def octave
    index / N_TONES
  end

  # Returns the index of the note in its current octave, where 0 is the first note
  # of the octave (A) and 11 is the last note of the octave (G#)
  def octave_index
    index % N_TONES
  end

  def value
    @value ||= A0 * BETA ** index
  end
end
