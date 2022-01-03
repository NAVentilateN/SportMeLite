class CoachProfile < ApplicationRecord
  belongs_to :sport
  belongs_to :user
  has_many_attached :photos

  validates :coach_start_date, presence: true
  validates :description, presence: true, length: { minimum: 8 }
  validates :sport, :user, presence: true

  def years_of_experience
    ((Time.zone.now - coach_start_date.to_time) / 1.year.seconds).floor
  end
end
