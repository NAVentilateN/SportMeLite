class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.string :location
      t.integer :price
      t.boolean :status
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :coach, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
