class RemoveContactNumberFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :Contact_number, :string
  end
end
