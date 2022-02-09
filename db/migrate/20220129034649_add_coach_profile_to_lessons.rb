class AddCoachProfileToLessons < ActiveRecord::Migration[6.1]
  def change
    add_reference :lessons, :coach_profile, foreign_key: true
    remove_reference :lessons, :coach
    remove_reference :lessons, :student
  end
end
