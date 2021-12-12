class Lesson < ApplicationRecord
  belongs_to :student, class_name: 'User', inverse_of: :lessons_to_attend, optional: true
  belongs_to :coach, class_name: 'User', inverse_of: :lessons_to_teach
  validates :coach, presence: true
  validates :start_date_time, :end_date_time, presence: true
  # validates_date :start_date_time, on: :create, on_or_after: :today
  validates_datetime :end_date_time, after: :start_date_time
  validates :location, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0, only_integer: true}, presence: true
  validates :status, inclusion: { in: [ true, false ] }
  validates :description, presence: true, length: {minimum: 4, maximum: 100}
end
