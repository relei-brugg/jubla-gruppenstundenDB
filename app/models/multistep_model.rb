
module MultistepModel

  attr_accessor :steps
  attr_writer :current_step

  def current_step
    @current_step || 0
  end

  def first_step?
    current_step == 0
  end

  def last_step?
    current_step == self.steps-1
  end

  def save_step?
    current_step == self.steps
  end

  def previous_step
    self.current_step -= 1 unless self.first_step?
  end

  def next_step
    self.current_step += 1 unless self.save_step?
  end

  def progress
    (self.current_step * 100) / self.steps
  end

  def all_valid?
    self.steps.times do |step|
      self.current_step = step
      valid?
    end
  end

end
