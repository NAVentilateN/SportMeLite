class CartItem < ApplicationRecord
    belongs_to :cart
    belongs_to :lesson

    validates :lesson, presence: true
end