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

    # Oscillator
    @synth = new Tone.PolySynth(1000).set({
      oscillator: {
        type: 'sine',
        modulationFrequency: 2
      },
      envelope: {
        attack:   4,
        decay:    10,
        sustain:  10,
        release:  0.2
      }
    }).toMaster()

  gen: (notes) ->
    
    @synth.triggerAttackRelease(notes, "2n")
    return notes
