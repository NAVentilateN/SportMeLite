class ChangeStudentIdToBeOptionalForLessons < ActiveRecord::Migration[6.1]
  def change
    change_column :lessons, :student_id, :integer, null: true
  end
end
