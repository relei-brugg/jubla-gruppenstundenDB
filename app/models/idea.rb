class Idea < ActiveRecord::Base

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :idea_ratings, dependent: :destroy
  has_and_belongs_to_many :method_categories
  has_and_belongs_to_many :activity_categories
  has_and_belongs_to_many :location_categories
  has_and_belongs_to_many :season_categories

  validates :title,                if: lambda { current_step_name == 'title' }, presence: true, length: { minimum: 5 }
  validates :start,                if: lambda { current_step_name == 'start' }, presence: true
  validates :main_part,            if: lambda { current_step_name == 'main' }, presence: true
  validates :end,                  if: lambda { current_step_name == 'end' }, presence: true
  validates :duration_preparation, if: lambda { current_step_name == 'title' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :duration_start,       if: lambda { current_step_name == 'start' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :duration_main_part,   if: lambda { current_step_name == 'main' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :duration_end,         if: lambda { current_step_name == 'end' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true

  validates :age_min,              if: lambda { current_step_name == 'kids' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :age_max,              if: lambda { current_step_name == 'kids' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :group_size_min,       if: lambda { current_step_name == 'kids' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true
  validates :group_size_min,       if: lambda { current_step_name == 'kids' }, numericality: {only_integer: true, greater_than_or_equal_to: 0 }, presence: true

  # Multistep form code
  include MultistepModel

  after_initialize do
    self.steps = %w[title kids method location start main end material]
  end
end
