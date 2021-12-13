class Review < ApplicationRecord
  belongs_to :lesson
  belongs_to :student, class_name: 'User', inverse_of: :review_by, optional: true

  validates :rating, presence: true
  validates :content, presence: true
end
