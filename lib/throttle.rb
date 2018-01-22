class Throttle
  attr_reader :millis
  def initialize(millis)
    @millis = millis
    @mark   = Time.now
  end

  def throttle
    if run_block?
      yield
      @mark = Time.now
    end
  end

  private

  def run_block?
    (Time.now - @mark) * 1000 >= millis
  end
end
