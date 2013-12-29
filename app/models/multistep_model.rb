
module MultistepModel

  attr_accessor :steps
  attr_writer :current_step

  def num_steps
    steps.count
  end

  def current_step
    @current_step || 0
  end

  def current_step_name
    steps[current_step]
  end

  def first_step?
    current_step == 0
  end

  def last_step?
    current_step == self.num_steps-1
  end

  def save_step?
    current_step == self.num_steps
  end

  def previous_step
    self.current_step -= 1 unless self.first_step?
  end

  def next_step
    self.current_step += 1 unless self.save_step?
  end

  def progress
    ((self.current_step) * 100) / (self.num_steps-1)
  end

  def all_valid?
    self.num_steps.times do |step|
      self.current_step = step
      valid?
    end
  end

end
