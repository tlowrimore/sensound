class Note
  A0        = 27.5
  BETA      = 1.0594631
  RANGE_IN  = [20, 600]
  RANGE_OUT = [0, 87]

  attr_reader :sensor_value

  def initialize(sensor_value)
    @sensor_value = sensor_value
  end

  def to_h
    {
      value:  sensor_value,
      note:   calc_note(scale_value(sensor_value))
    }
  end

  private

  def scale_value(x)
    (RANGE_OUT.max - RANGE_OUT.min) * (x - RANGE_IN.min) /
    (RANGE_IN.max - RANGE_IN.min)
  end

  def calc_note(x)
    A0 * BETA ** x
  end
end
