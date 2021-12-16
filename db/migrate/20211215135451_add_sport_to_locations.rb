class AddSportToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :sport, :string
  end
end
