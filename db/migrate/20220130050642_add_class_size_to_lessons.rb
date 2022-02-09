class AddClassSizeToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :size, :integer
  end
end
