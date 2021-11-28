class CoachProfile < ApplicationRecord
  belongs_to :sport
  belongs_to :user

  validates :coach_start_date, presence: true, on_or_before: :today
  validates :description, presence: true, length: { minimum: 8 }
end
