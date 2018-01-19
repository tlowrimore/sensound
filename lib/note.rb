class Note
  A0          = 27.5
  BETA        = 1.0594631
  RANGE_IN    = [20, 600]
  RANGE_OUT   = [0, 87]
  RANGE_SIZE  = 88

  # -----------------------------------------------------
  # Class Methods
  # -----------------------------------------------------

  class << self
    def create_from_sensor(sensor_value)
      index_value = calculate_index(sensor_value)
      new(index_value)
    end

    private

    def calculate_index(sensor_value)
      (RANGE_OUT.max - RANGE_OUT.min) * (sensor_value - RANGE_IN.min) / (RANGE_IN.max - RANGE_IN.min)
    end
  end

  # -----------------------------------------------------
  # Instance Methods
  # -----------------------------------------------------

  attr_reader :index_value

  def initialize(index_value=nil)
    if index_value.nil?
      raise ArgumentError,
            "An index_value must be supplied to constructor"
    end

    @index_value  = index_value
  end

  def next(step=1)
    index = (index_value + step) % RANGE_SIZE
    Note.new(index)
  end

  def previous(step=1)
    index = (index_value - step) % RANGE_SIZE
    Note.new(index)
  end

  def to_h
    { value: value, index:  index_value }
  end

  def value
    @value ||= A0 * BETA ** index_value
  end
end
