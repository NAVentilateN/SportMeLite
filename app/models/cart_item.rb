class CartItem < ApplicationRecord
    belongs_to :cart, optional: true
    belongs_to :lesson

    validates :lesson, presence: true
end