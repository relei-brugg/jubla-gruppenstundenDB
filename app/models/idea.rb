class Idea < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  #has_and_belongs_to_many :activity_categories
  #has_and_belongs_to_many :age_categories
  #has_and_belongs_to_many :group_size_categories
  #has_and_belongs_to_many :location_categories
  #has_and_belongs_to_many :method_categories
  #has_and_belongs_to_many :season_categories

  validates :title, presence: true, length: { minimum: 5 }, if: :first_step?


  # Multistep form code
  attr_writer :current_step

  def current_step
    @current_step || steps.first
  end

  def steps
    %w[1 2 3]
  end

  def progress
    ((self.current_step.to_d-1) / self.steps.count * 100).to_i
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end

  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end
end
