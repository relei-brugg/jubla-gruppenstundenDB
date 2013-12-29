class Idea < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  #has_and_belongs_to_many :group_size_categories

  validates :title,     if: lambda { current_step == 0 }, presence: true, length: { minimum: 5 }
  validates :main_part, if: lambda { current_step == 1 }, presence: true
  validates :end,       if: lambda { current_step == 2 }, presence: true


  # Multistep form code
  include MultistepModel

  after_initialize do
    self.steps = 4
  end

end
