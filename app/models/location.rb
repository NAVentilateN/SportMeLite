class Location < ApplicationRecord
  has_many :lessons
  has_many :coaches, through: :lessons
  has_many :sports, through: { coaches: :coach_profile }
  validates :name, uniqueness: true

  filterrific(
    available_filters: [:with_sport, :with_location]
  )

  scope :with_sport, ->(sport) {
    where("sports.name = ?", sport.downcase).joins(lessons: { coach: { coach_profile: :sport } })
  }

  # scope :with_price, ->(min, max) {
  #   where(lesson: { price => min && price <= max }).joins(:lesson)
  # }

  scope :with_location, ->(location) {
    where("locations.id = ?", location)
  }

  def self.options_for_sport_select
     Sport.all.map(&:name).map(&:capitalize)
  end

  def self.options_for_location_select
    Location.all
            .select { |location| location.lessons.select_active_lessons.count.positive? }
            .map { |location| [location.name.camelize, location.id] }
            .sort
  end
end
