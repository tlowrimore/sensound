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

  def ascending(scale_name, octaves: 1)
    scale_name  = scale_name.to_sym
    scale       = octaves.times.map { SCALES[scale_name] }.flatten

    ref = @root
    scale.map do |interval|
      ref = ref.next(interval)
    end
  end

  def descending(scale_name, octaves: 1)
    scale_name  = scale_name.to_sym
    scale       = octaves.times.map { SCALES[scale_name] }.flatten

    ref = @root
    scale.reverse.map do |interval|
      ref = ref.previous(interval)
    end
  end
end
