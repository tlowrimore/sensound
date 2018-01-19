class ParticipantBroadcaster < Broadcaster
  def broadcast(note)
    ActionCable.server.broadcast stream_name, note.value
  end
end
