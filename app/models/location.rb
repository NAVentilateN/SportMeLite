class Location < ApplicationRecord
  has_many :lessons
  has_many :sports, through: :lessons
  validates :name, uniqueness: true

  filterrific(
    available_filters: [:with_sport, :with_price]
  )

  scope :with_sport, ->(sports) {
    where(sports: { name: sports }).joins(lessons: :sport)
  }

  scope :with_price, ->(min, max) {
    where(lesson: { price => min && price <= max }).joins(:lesson)
  }

  def self.options_for_sport_select
    Sport.all.map(&:name)
  end
end
