class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :contact_number, :string
  end
end
