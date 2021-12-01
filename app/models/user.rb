class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lessons_to_attend, class_name: 'Lesson', foreign_key: 'student_id', inverse_of: :student
  has_many :lessons_to_teach, class_name: 'Lesson', foreign_key: 'coach_id', inverse_of: :coach

  validates :name, presence: true, length: { minimum: 6 }
  validates_date :date_of_birth, on_or_before: :today
  validates :contact_number, presence: true, length: { minimum: 8 }
end
