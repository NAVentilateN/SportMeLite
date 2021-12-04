class AddPictureUrlToSports < ActiveRecord::Migration[6.1]
  def change
    add_column :sports, :picture_url, :string
  end
end
