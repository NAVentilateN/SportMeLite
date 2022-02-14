class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  validates :user, presence: true
end
