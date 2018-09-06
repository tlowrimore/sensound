class window.Viz
  SATURATION      = '100%'
  OUTER_LIGHTNESS = '20%'
  INNER_LIGHTNESS = '50%'

  instance      = null


  # -----------------------------------------------------
  # Class Methods
  # -----------------------------------------------------

  @initialize: ->
    return if instance?
    instance = new Viz()

  @deinitialize: ->
    return unless instance?
    instance = null

  @gen: (notes) ->
    return unless instance?

    instance.gen(notes)

  # ---------------------------------------------------------
  # Instance Methods
  # ---------------------------------------------------------

  gen: (notes) ->
    note  = notes[0]
    outer = "hsl(#{note + 30}, #{SATURATION}, #{OUTER_LIGHTNESS})"
    inner = "hsl(#{note}, #{SATURATION}, #{INNER_LIGHTNESS})"
    innerSize  = (note / window.innerWidth) * 100 - 20
    outerSize  = innerSize + 20

    $('.viz')
    .css(
      'background',
      "radial-gradient(circle, #{inner} #{innerSize}%, #{outer} #{outerSize}%, black #{outerSize + 3}%, black)"
    )
