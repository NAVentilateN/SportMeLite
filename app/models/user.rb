class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :coach_profile
  has_one :sport, through: :coach_profile
  has_many :lessons
  has_many :students, through: :lessons
  validates :name, presence: true, length: { minimum: 6 }
  validates_date :date_of_birth, on_or_before: :today
  validates :contact_number, presence: true, length: { minimum: 8 }
end
