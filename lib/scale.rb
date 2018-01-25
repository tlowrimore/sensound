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

  # -----------------------------------------------------
  # Instance Methods
  # -----------------------------------------------------

  attr_reader :name, :tonic

  def initialize(tonic, name)
    @tonic  = tonic
    @name   = name.to_sym
  end

  def notes(octaves: 1)
    scale = octaves.times.map { SCALES[name] }.flatten

    ref = @tonic
    scale.map do |interval|
      ref = ref.step(interval)
    end
  end
end
