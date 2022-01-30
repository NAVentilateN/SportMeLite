class Order < ApplicationRecord
  belongs_to :user
  has_many :bookings

  monetize :amount_cents
  validates :user, :booking, presence: true

  scope :last_days, -> { where(['created_at > ?', 5.days.ago]) }
end
