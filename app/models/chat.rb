class Chat < ApplicationRecord
  has_many :messages
  has_many :users, through: :messages
  belongs_to :student, class_name: 'User', inverse_of: :chats_with_coach
  belongs_to :coach, class_name: 'User', inverse_of: :chats_with_student
  # scope :public_rooms, -> { where(is_private: false) }

  validates_uniqueness_of :student_id, scope: :coach_id

  scope :between, -> (student_id,coach_id) do
    where("(chats.student_id = ? AND chats.coach_id = ?) OR (chats.coach_id = ? AND chats.student_id = ?)", student_id, coach_id, student_id, coach_id)
  end
end
