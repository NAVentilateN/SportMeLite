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
  has_many :notifications_received, class_name: 'Notification', foreign_key: 'recipient_id', inverse_of: :recipient
  has_many :notifications_sent, class_name: 'Notification', foreign_key: 'sender_id', inverse_of: :sender

  validates :name, presence: true, length: { minimum: 6 }
  validates_date :date_of_birth, on_or_before: :today, allow_blank: true
  validates :contact_number, length: { minimum: 8 }, allow_blank: true

  validates_uniqueness_of :email
  scope :all_except, ->(user) { where.not(id: user) }

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

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

  filterrific(
    available_filters: [:sorted_by, :with_gender]
  )

  scope :with_gender, ->(genders) {
    where(gender: [*genders])
  }

  scope :sorted_by, -> (sort_key) {
    direction = /desc$/.match?(sort_key) ? "desc" : "asc"
    case sort_key
    when /^age/
      order("users.date_of_birth #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_key.inspect}")
    end
  }


  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def self.options_for_select
    order("gender").map(&:gender).uniq
  end

  def self.options_for_sorted_by
    [
      ["Age (Asc)", "age_asc"],
      ["Age (Desc)", "age_desc"]
    ]
  end
end
