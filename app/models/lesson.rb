class Lesson < ApplicationRecord
  belongs_to :student_id
  belongs_to :coach_id
  validates :coach, presence: true
  validates :start_time, :end_time, presence:true
  validates_date :start_time, on: :create, on_or_after: :today
  validates_datetime :end_time, after: :start_time
  validates :location, presence: true
  validates :price, numericality: true, presence: true
  validates :status, presence: true, inclusion: { in: [ true, false ] }
end
