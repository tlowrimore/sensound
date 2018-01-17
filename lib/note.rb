class Note
  A0        = 27.5
  BETA      = 1.0594631
  RANGE_IN  = [20, 600]
  RANGE_OUT = [0, 87]

  attr_reader :sensor_value

  # -----------------------------------------------------
  # Instance Methods
  # -----------------------------------------------------

  def initialize(sensor_value: nil, index_value: nil)
    if sensor_value.nil? && index_value.nil?
      raise ArgumentError,
            "Either a sensor_value or an index_value must be supplied to constructor"
    end

    @sensor_value = sensor_value || 0
    @index_value  = index_value
  end

  def next(step=1)
    Note.new(index_value: index_value + step)
  end

  def previous(step=1)
    Note.new(index_value: index_value - step)
  end

  def to_h
    {
      value:  sensor_value,
      index:  index_value,
      note:   note_value
    }
  end

  def index_value
    @index_value ||=
      (RANGE_OUT.max - RANGE_OUT.min) * (sensor_value - RANGE_IN.min) /
      (RANGE_IN.max - RANGE_IN.min)
  end

  def note_value
    @note_value ||= A0 * BETA ** index_value
  end
end
