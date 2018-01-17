class Broadcaster
  attr_reader :stream_name, :seed

  def initialize(stream_name)
    @stream_name  = stream_name
    @seed         = rand
  end

  def call(value)
    note = Note.new(sensor_value: value)
    ActionCable.server.broadcast stream_name, note.to_h
  end
end
