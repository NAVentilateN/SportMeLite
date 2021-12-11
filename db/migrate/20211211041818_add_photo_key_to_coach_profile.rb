class AddPhotoKeyToCoachProfile < ActiveRecord::Migration[6.1]
  def change
      add_column :coach_profiles, :photo_key, :string
  end
end
