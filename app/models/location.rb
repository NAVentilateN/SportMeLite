class Location < ApplicationRecord
  validates :name, uniqueness: true
end
