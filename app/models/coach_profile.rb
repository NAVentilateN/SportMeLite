class CoachProfile < ApplicationRecord
  belongs_to :sport
  belongs_to :user
end
