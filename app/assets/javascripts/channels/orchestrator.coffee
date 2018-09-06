#= require ../sound-gen
#= require ../viz

App.orchestrator = App.cable.subscriptions.create "OrchestratorChannel",
  connected: ->
    console.log('connected!')
    SoundGen.initialize()
    # Viz.initialize()

  disconnected: ->
    console.log("connection lost!")
    SoundGen.deinitialize()
    # Viz.deinitialize()

  received: (notes) ->
    SoundGen.gen(notes)
    # Viz.gen(notes)
