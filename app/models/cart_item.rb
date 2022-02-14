class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :lesson

  validates :cart, :lesson, presence: true
end
