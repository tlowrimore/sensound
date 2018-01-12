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
    # Stereo Widener
    widener = new Tone.StereoWidener({width: 1}).toMaster()

    # Reverb
    @freeverb = new Tone.Freeverb().connect(widener)

    # Oscillator
    @synth = new Tone.MonoSynth({
      oscillator: {
        type: 'sine',
        modulationFrequency: 2
      },
      envelope: {
        attack:   2,
        decay:    2,
        sustain:  1,
        release:  4
      }
    }).connect(@freeverb)

  gen: (note, val) ->
    if val % 2 == 0
      @freeverb.dampening.value = val * 10;

      @synth.triggerAttackRelease(note, "8n")
      return note
