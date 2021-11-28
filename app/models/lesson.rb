class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :coach_profile
  validates :coach_profile, presence: true
  validates :start_time, :end_time, presence:true
  validates_date :start_time, on: :create, on_or_after: :today
  validates_datetime :end_time, after: :start_time
  validates :location, presence: true
  validates :price, numericality: true, presence: true
  validates :status, presence: true, inclusion: { in: [ true, false ] }
end
