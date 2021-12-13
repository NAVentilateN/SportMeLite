class Review < ApplicationRecord
  belongs_to :lesson
  belongs_to :coach, class_name: 'User', inverse_of: :coach_review, optional: true
  belongs_to :student, class_name: 'User', inverse_of: :student_review

  validates :rating, presence: true
  validates :content, presence: true
end
