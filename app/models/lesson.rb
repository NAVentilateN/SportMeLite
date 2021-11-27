class Lesson < ApplicationRecord
  belongs_to :student_id
  belongs_to :coach_id
end
