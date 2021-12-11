class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :rating
      t.references :lesson, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
