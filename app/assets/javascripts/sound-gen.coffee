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

  @gen: (val) ->
    return unless instance?

    instance.gen(val)

  # ---------------------------------------------------------
  # Constructor & Instance Methods
  # ---------------------------------------------------------

  constructor: ->
    # Stereo Widener
    widener = new Tone.StereoWidener({width: 1}).toMaster()

    # Reverb
    @freeverb = new Tone.Freeverb().connect(widener)

    # Phaser
    phaser  = new Tone.Phaser({
              	"frequency":     1,
              	"octaves":       5
              	"baseFrequency": 1000
              }).connect(@freeverb);

    # Oscillator
    @synth = new Tone.MonoSynth({
      oscillator: {
        type: 'sine',
        modulationFrequency: 2
      },
      envelope: {
        attack:   20,
        decay:    20,
        sustain:  1,
        release:  4
      }
    }).connect(phaser)

  gen: (val) ->
    if val % 2 == 0
      @freeverb.dampening.value = val * 10;
      @synth.triggerAttackRelease(val * 3, "8n")
