class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  validate :user, presence: true
  validate :lesson, presence: true
end
