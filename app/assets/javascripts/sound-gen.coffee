class window.SoundGen
  instance = null

  # ---------------------------------------------------------
  # Class Methods
  # ---------------------------------------------------------

  @initialize: ->
    return if instance?
    instance = new SoundGen()

  @deinitialize: ->
    return unless instance?

    # do some cleanup.
    instance = null

  @gen: (notes) ->
    return unless instance?

    instance.gen(notes)

  # ---------------------------------------------------------
  # Constructor & Instance Methods
  # ---------------------------------------------------------

  constructor: ->
    pingPong = new Tone.PingPongDelay("16n", 0.1).toMaster();

    # Oscillator
    @synth = new Tone.PolySynth(1000).set({
      oscillator: {
        type: 'sine',
        modulationFrequency: 2
      },
      envelope: {
        attack:   2,
        decay:    0.1,
        sustain:  0.1,
        release:  0.2
      }
    }).connect(pingPong)

  gen: (notes) ->

    @synth.triggerAttackRelease(notes, "4n")
    return notes
