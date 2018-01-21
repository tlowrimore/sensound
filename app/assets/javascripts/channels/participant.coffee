App.participant = App.cable.subscriptions.create "ParticipantChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (note) ->
    SoundGen.gen(note)
