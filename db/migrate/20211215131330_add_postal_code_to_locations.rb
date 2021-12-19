class AddPostalCodeToLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :postalcode, :integer
  end
end
