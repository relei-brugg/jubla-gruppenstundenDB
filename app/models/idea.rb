class Idea < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :activity_categories
  has_and_belongs_to_many :age_categories
  has_and_belongs_to_many :group_size_categories
  has_and_belongs_to_many :location_categories
  has_and_belongs_to_many :method_categories
  has_and_belongs_to_many :season_categories

  validates :title, presence: true, length: { minimum: 5 }
end
