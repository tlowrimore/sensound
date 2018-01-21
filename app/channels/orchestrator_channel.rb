class OrchestratorChannel < ApplicationCable::Channel
  STREAM_NAME = 'orchestration'

  def subscribed
    stream_from STREAM_NAME

    @broadcaster = OrchestratorBroadcaster.new(STREAM_NAME)
    NoteEmitter.subscribe(@broadcaster)
  end

  def unsubscribed
    NoteEmitter.unsubscribe(@broadcaster)
  end
end
