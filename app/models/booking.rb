class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  belongs_to :order

    validates :user, :lesson, :order, presence: true
end
