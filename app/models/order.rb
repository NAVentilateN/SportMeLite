class Order < ApplicationRecord
  belongs_to :user
  belongs_to :lesson

  monetize :amount_cents
end
