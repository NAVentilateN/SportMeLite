class Lesson < ApplicationRecord
  belongs_to :student, class_name: 'User', inverse_of: :lessons_to_attend, optional: true
  belongs_to :coach, class_name: 'User', inverse_of: :lessons_to_teach
  belongs_to :location
  has_one :review
  has_one :order

  monetize :price_cents

  validates :coach, presence: true
  validates :start_date_time, :end_date_time, presence: true
  # validates_date :start_date_time, on: :create, on_or_after: :today
  validates_datetime :end_date_time, after: :start_date_time
  validates :location, presence: true
  validates :price_cents, numericality: { greater_than_or_equal_to: 0, only_integer: true }, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates :description, presence: true, length: { minimum: 4, maximum: 100 }

  filterrific(
    available_filters: [:sorted_by, :with_location_name]
  )
  scope :with_location_name, ->(location_name) {
    where(location: { name: location_name }).joins(:location)
  }

  scope :sorted_by, -> (sort_key) {
    direction = /desc$/.match?(sort_key) ? "desc" : "asc"
    case sort_key
    when /^duration/
      order("lessons.end_date_time #{direction}")
    when /^price/
      order("lessons.price_cents #{direction}")
    else
      raise(ArgumentError, "Invalid sort option: #{sort_key.inspect}")
    end
  }


  def duration
    ((end_date_time.to_time - start_date_time.to_time) / 1.year.seconds).floor
  end

  def self.options_for_select(user_id)
    lessons_list = User.find(user_id).lessons_to_teach.map do |lesson|
      if lesson.start_date_time > Date.today && !lesson.status
        lesson.location.name
      end
    end
    lessons_list.compact.uniq.sort
  end

  def self.options_for_sorted_by
    [
      ["Duration (Lowest to Highest)", "duration_asc"],
      ["Duration (Highest to Lowest)", "duration_desc"],
      ["Price (Lowest to Highest)", 'price_asc'],
      ["Price (Highest to Lowest)", "price_desc"]
    ]
  end
end
