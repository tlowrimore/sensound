class SensorChannel < ApplicationCable::Channel
  STREAM_NAME = 'sensor_readings'

  def subscribed
    stream_from STREAM_NAME

    @broadcaster = -> (value) {
      ActionCable.server.broadcast STREAM_NAME, value
    }

    SerialReader.subscribe(&@broadcaster)
  end

  def unsubscribed
    SerialReader.unsubscribe(&@broadcaster)
  end
end
