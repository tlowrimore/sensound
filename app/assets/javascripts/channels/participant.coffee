promise = StartAudioContext(Tone.context, '#btn-participate').then ->

  App.participant = App.cable.subscriptions.create "ParticipantChannel",
    connected: ->
      SoundGen.initialize()

    disconnected: ->
      SoundGen.deinitialize()

    received: (note) ->
      SoundGen.gen(note)
