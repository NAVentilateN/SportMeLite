class Lesson < ApplicationRecord
  belongs_to :student_id
  belongs_to :coach_id
  validates :coach_id, presence: true
  validates :start_date_time, :end_date_time, presence:true
  validates_date :start_date_time, on: :create, on_or_after: :today
  validates_datetime :end_date_time, after: :start_date_time
  validates :location, presence: true
  validates :price, numericality: true, presence: true
  validates :status, presence: true, inclusion: { in: [ true, false ] }
end
