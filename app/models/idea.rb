class Idea < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  #has_and_belongs_to_many :group_size_categories

  validates :title, presence: true, length: { minimum: 5 }, if: lambda { current_step == 0 }
  validates :main_part, presence: true, if: lambda { current_step == 1 }
  validates :end, presence: true, if: lambda { current_step == 2 }


  # Multistep form code
  include MultistepModel

  after_initialize do
    self.steps = 3
  end

end
