#= require ../sound-gen

App.sensor = App.cable.subscriptions.create "SensorChannel",
  connected: ->
    console.log("connection established!")
    SoundGen.initialize()

  disconnected: ->
    console.log("connection lost!")
    SoundGen.deinitialize()

  received: (data) ->
    SoundGen.gen(data.note, data.value)
