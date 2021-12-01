class AddDescriptionToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :description, :string
  end
end
