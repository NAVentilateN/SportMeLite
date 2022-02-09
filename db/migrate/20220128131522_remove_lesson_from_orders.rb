class RemoveLessonFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :lesson
  end
end
