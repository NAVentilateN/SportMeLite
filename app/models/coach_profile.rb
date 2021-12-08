class CoachProfile < ApplicationRecord
  belongs_to :sport
  belongs_to :user
  has_many_attached :photos

  validates :coach_start_date, presence: true
  validates :description, presence: true, length: { minimum: 8 }
  validates :sport, :user, presence: true
end
