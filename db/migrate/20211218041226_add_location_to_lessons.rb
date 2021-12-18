class AddLocationToLessons < ActiveRecord::Migration[6.1]
  def change
    add_reference :lessons, :location, foreign_key: true
  end
end
