class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :photo
  has_one :coach_profile, dependent: :destroy
  has_one :sport, through: :coach_profile
  has_many :lessons_to_attend, class_name: 'Lesson', foreign_key: 'student_id', inverse_of: :student
  has_many :lessons_to_teach, class_name: 'Lesson', foreign_key: 'coach_id', inverse_of: :coach
  has_many :students, through: :lessons
  has_many :review_by, class_name: 'Review', foreign_key: 'student_id', inverse_of: :student
  has_many :chats_with_coach, class_name: 'Chat', foreign_key: 'student_id', inverse_of: :student
  has_many :chats_with_student, class_name: 'Chat', foreign_key: 'coach_id', inverse_of: :coach
  # has_many :coach_review, class_name: 'Review', foreign_key: 'coach_id', inverse_of: :coach
  # has_many :student_review, class_name: 'Review', foreign_key: 'student_id', inverse_of: :student
  has_many :orders

  validates :name, presence: true, length: { minimum: 6 }
  validates_date :date_of_birth, on_or_before: :today, allow_blank: true
  validates :contact_number, length: { minimum: 8 }, allow_blank: true

  validates_uniqueness_of :email
  scope :all_except, ->(user) { where.not(id: user) }

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    
    # Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: '111111',
          #  password: Devise.friendly_token[0,20],
           access_token: access_token.credentials.token,
           expires_at: access_token.credentials.expires_at,
          refresh_token: access_token.credentials.refresh_token,
          uid: access_token.uid,
          provider: access_token.provider
        )
    end
    user
  end

  def expired?
    expires_at < Time.current.to_i
  end 

end
