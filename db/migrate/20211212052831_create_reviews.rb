class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :content
      t.references :lesson, null: false, foreign_key: { to_table: :lessons }
      t.references :coach, null: false, foreign_key: { to_table: :users }
      t.references :student, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
