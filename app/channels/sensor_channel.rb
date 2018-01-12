class SensorChannel < ApplicationCable::Channel
  STREAM_NAME = 'sensor_readings'

  def subscribed
    stream_from STREAM_NAME

    @broadcaster = -> (value) {
      note = Note.new(value)
      ActionCable.server.broadcast STREAM_NAME, note.to_h
    }

    SerialEmitter.subscribe(&@broadcaster)
  end

  def unsubscribed
    SerialEmitter.unsubscribe(&@broadcaster)
  end
end
