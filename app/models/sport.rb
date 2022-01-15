class Sport < ApplicationRecord
  validates :name, presence: true
  has_many :coach_profile
  has_many :users, through: :coach_profile
  has_many :lessons
end
