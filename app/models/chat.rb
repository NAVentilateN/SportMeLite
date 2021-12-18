class Chat < ApplicationRecord
  has_many :messages
  belongs_to :student, class_name: 'User', inverse_of: :chats_with_coach
  belongs_to :coach, class_name: 'User', inverse_of: :chats_with_student
  # scope :public_rooms, -> { where(is_private: false) }
end
