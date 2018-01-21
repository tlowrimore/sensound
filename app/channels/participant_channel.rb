class ParticipantChannel < ApplicationCable::Channel
  STREAM_NAME = 'participation'

  def subscribed
    stream_from STREAM_NAME

    @broadcaster = ParticipantBroadcaster.new(STREAM_NAME)
  end

  def unsubscribed
    @broadcaster.finalize
  end
end
