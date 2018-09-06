view =
  end: ->
    $("#btn-participate").show()
    $("#notice-joined").hide()

  begin: ->
    $("#btn-participate").hide()
    $("#notice-joined").show()

promise = StartAudioContext(Tone.context, '#btn-participate').then ->

  App.participant = App.cable.subscriptions.create "ParticipantChannel",
    connected: ->
      SoundGen.initialize()
      view.begin()

    disconnected: ->
      SoundGen.deinitialize()
      view.end()

    received: (note) ->
      SoundGen.gen(note)
