class RemovePriceFromLessons < ActiveRecord::Migration[6.1]
  def change
    remove_column :lessons, :price
  end
end
