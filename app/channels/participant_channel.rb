class ParticipantChannel < ApplicationCable::Channel
  STREAM_NAME_BASE = 'participation'

  def subscribed
    stream_from stream_name

    @broadcaster = ParticipantBroadcaster.new(stream_name)
  end

  def unsubscribed
    @broadcaster.finalize
  end

  private

  def stream_name
    @stream_name ||= [STREAM_NAME_BASE, SecureRandom.uuid].join('-')
  end
end
