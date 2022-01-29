class RemoveLessonFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :orders, :lesson, :integer
  end
end
