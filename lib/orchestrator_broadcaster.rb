class OrchestratorBroadcaster < Broadcaster
  def broadcast(sensor_value)
    note  = Note.create_from_sensor(sensor_value)
    scale = Scale.new(note)
    notes = scale.ascending(:major, octaves: 7)

    # Iterate all registered broadcasters
    chord = Broadcaster.map do |broadcaster|

      # skip self to avoid infinite recursion
      next note if broadcaster == self

      # broadcast random note from our scale and return the note
      notes.sample.tap do |n|
        broadcaster.broadcast(n)
      end
    end

    ActionCable.server.broadcast stream_name, chord.map(&:value)
  end
end
