class CreateCoachProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :coach_profiles do |t|
      t.date :coach_start_date
      t.text :description
      t.references :sport, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
