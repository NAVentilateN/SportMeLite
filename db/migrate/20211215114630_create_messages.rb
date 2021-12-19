class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :chat, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
