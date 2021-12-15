class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_one :coach_profile, dependent: :destroy
  has_one :sport, through: :coach_profile
  has_many :lessons_to_attend, class_name: 'Lesson', foreign_key: 'student_id', inverse_of: :student
  has_many :lessons_to_teach, class_name: 'Lesson', foreign_key: 'coach_id', inverse_of: :coach
  has_many :students, through: :lessons
  has_many :review_by, class_name: 'Review', foreign_key: 'student_id', inverse_of: :student
  # has_many :coach_review, class_name: 'Review', foreign_key: 'coach_id', inverse_of: :coach
  # has_many :student_review, class_name: 'Review', foreign_key: 'student_id', inverse_of: :student

  validates :name, presence: true, length: { minimum: 6 }
  validates_date :date_of_birth, on_or_before: :today
  validates :contact_number, presence: true, length: { minimum: 8 }

  validates_uniqueness_of :email
  scope :all_except, ->(user) { where.not(id: user) }
end
