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

  @gen: (note, val) ->
    return unless instance?

    instance.gen(note, val)

  # ---------------------------------------------------------
  # Constructor & Instance Methods
  # ---------------------------------------------------------

  constructor: ->

    # Oscillator
    @synth = new Tone.MonoSynth({
      oscillator: {
        type: 'sine',
        modulationFrequency: 2
      },
      envelope: {
        attack:   0.05,
        decay:    0.2,
        sustain:  0.2,
        release:  0.2
      }
    }).toMaster()

  gen: (note, val) ->
    @synth.triggerAttackRelease(note, "8n")
    return note
