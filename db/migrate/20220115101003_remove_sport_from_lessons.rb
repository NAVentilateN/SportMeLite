class RemoveSportFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_reference :lessons, :sport
  end
end
