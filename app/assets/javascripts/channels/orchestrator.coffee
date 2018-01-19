#= require ../sound-gen

App.orchestrator = App.cable.subscriptions.create "OrchestratorChannel",
  connected: ->
    console.log("connection established!")
    SoundGen.initialize()

  disconnected: ->
    console.log("connection lost!")
    SoundGen.deinitialize()

  received: (data) ->
    SoundGen.gen(data.note, data.value)
