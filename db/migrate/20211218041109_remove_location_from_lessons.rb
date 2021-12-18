class RemoveLocationFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :location, :string
  end
end
