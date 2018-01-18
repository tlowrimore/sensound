class Broadcaster
  attr_reader :stream_name, :seed

  def initialize(stream_name)
    @stream_name  = stream_name
    @seed         = rand
  end

  def call(value)
    note  = Note.new(sensor_value: value)
    scale = Scale.new(note)

    scale.ascending(:major).each do |n|
      ActionCable.server.broadcast stream_name, n.to_h
      sleep 0.1
    end
  end
end
