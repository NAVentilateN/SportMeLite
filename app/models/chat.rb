class Chat < ApplicationRecord
  has_many :messages
  validates_uniqueness_of :name
  # scope :public_rooms, -> { where(is_private: false) }
end
