class Order < ApplicationRecord
  belongs_to :user

  monetize :amount_cents

  scope :last_days, -> { where(['created_at > ?', 5.days.ago]) }
end
