class AddSportsToLessons < ActiveRecord::Migration[6.1]
  def change
    add_reference :lessons, :sport
    Lesson.all.each do |lesson|
      lesson.sport_id = lesson.coach.sport.id
      lesson.save!
    end
    change_column_null :lessons, :sport_id, false
    add_foreign_key :lessons, :sports
  end
end
