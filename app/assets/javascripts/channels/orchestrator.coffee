#= require ../sound-gen

App.orchestrator = App.cable.subscriptions.create "OrchestratorChannel",
  connected: ->
    console.log("connection established!")
    SoundGen.initialize()

  disconnected: ->
    console.log("connection lost!")
    SoundGen.deinitialize()

  received: (notes) ->
    SoundGen.gen(notes)
