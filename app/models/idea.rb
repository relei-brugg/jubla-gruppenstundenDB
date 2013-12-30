class Idea < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :group_size_categories
  has_and_belongs_to_many :age_categories

  validates :title,              if: lambda { current_step_name == 'title' }, presence: true, length: { minimum: 5 }
  validates :start,              if: lambda { current_step_name == 'start' }, presence: true
  validates :main_part,          if: lambda { current_step_name == 'main' }, presence: true
  validates :end,                if: lambda { current_step_name == 'end' }, presence: true
  validates :duration_start,     if: lambda { current_step_name == 'start' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :duration_main_part, if: lambda { current_step_name == 'main' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :duration_end,       if: lambda { current_step_name == 'end' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true


  # Multistep form code
  include MultistepModel

  after_initialize do
    self.steps = %w[title kids start main end material]
  end

end
