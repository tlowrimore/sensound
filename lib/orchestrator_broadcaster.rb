class OrchestratorBroadcaster < Broadcaster
  SENSOR_VALUE_LOWER_BOUND  = 60
  OCTAVE_RANGE              = 1

  def broadcast(sensor_value)
    sensor_value = sensor_value.to_i
    return if sensor_value < SENSOR_VALUE_LOWER_BOUND

    # Root note, derived from sensor reading
    @note = Note.create_from_sensor(sensor_value)

    # The current octave of the root note.
    octave = @note.octave

    # When generating participant notes, keep them with this range.
    octave_range = OCTAVE_RANGE.times.map { |i| (i - 1) + octave }

    # Create a new scale, setting its root.
    scale = Scale.new(@note)

    # Calculate all note of the named scale over n octaves.
    notes = scale.notes(:major, octaves: 7)

    # Iterate all registered broadcasters, broadcasting each note, and
    # building a chord from all selected notes.
    chord = Broadcaster.map do |broadcaster|

      # skip self to avoid infinite recursion
      next @note if broadcaster == self

      # broadcast random note from our scale and return the note
      notes.sample.tap do |n|
        to_octave = octave_range.sample
        n_shifted = n.shift(to_octave)
        broadcaster.broadcast(n_shifted)
      end
    end

    ActionCable.server.broadcast stream_name, chord.map(&:value)
  end
end
