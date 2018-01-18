class Scale
  SCALES = {
    major:              [2,2,1,2,2,2,1],
    minor:              [2,1,2,2,1,2,2],
    harmonic_minor:     [2,1,2,2,1,3,1],
    melodic_minor_asc:  [2,1,2,2,2,2,1],
    melodic_minor_desc: [2,2,1,2,2,1,2],
    dorian:             [2,1,2,2,2,1,2],
    mixolydian:         [2,2,1,2,2,1,2],
    ahava_raba:         [1,3,1,2,1,2,2],
    minor_pentatonic:   [3,2,2,3,2]
  }

  attr_reader :root

  def initialize(root)
    @root = root
  end

  def ascending(scale_name)
    scale_name  = scale_name.to_sym
    scale       = SCALES[scale_name]

    ref = @root
    scale.map do |interval|
      ref = ref.next(interval)
    end
  end

  def descending(scale_name)
    scale_name  = scale_name.to_sym
    scale       = SCALES[scale_name]

    ref = @root
    scale.reverse.map do |interval|
      ref = ref.previous(interval)
    end
  end
end
