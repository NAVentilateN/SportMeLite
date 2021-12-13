class Review < ApplicationRecord
  belongs_to :lesson

  validates :rating, presence: true
  validates :content, presence: true
end
