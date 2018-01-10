# The lowest note in our range, represented as Hz.
A0        = 27.5

# Twelfth root of two.  We'll use this to calculate the note we want to play
# from a twelve tone scale, over ~7 octaves.
BETA      = 1.0594631

# Represents the range of values streaming from the IR sensor.
RANGE_IN  = [20, 600]

# Represents the range of values used to generate notes from our western scale.
RANGE_OUT = [0, 87]

# localize min and max functions for convenience and speed.
min = Math.min
max = Math.max

# Scales the sensor values (RANGE_IN) down, into our note range (RANGE_OUT)
scale = (x) ->
  (max(RANGE_OUT...) - min(RANGE_OUT...)) * (x - min(RANGE_IN...)) /
  (max(RANGE_IN...) - min(RANGE_IN...))

# # Calculate the note for x, where x is an element in RANGE_OUT
note = (x) -> A0 * (BETA ** x)

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
    # phaser  = new Tone.Phaser({
    #           	"frequency":     1,
    #           	"octaves":       5
    #           	"baseFrequency": 1000
    #           }).connect(@freeverb);

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

  gen: (val) ->
    if val % 2 == 0
      @freeverb.dampening.value = val * 10;

      _note = note(scale(val))
      @synth.triggerAttackRelease(_note, "8n")
      return _note
