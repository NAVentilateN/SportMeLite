class AddReferencesToChat < ActiveRecord::Migration[6.1]
  def change
    add_reference :chats, :coach, foreign_key: { to_table: :users }
    add_reference :chats, :student, foreign_key: { to_table: :users }
  end
end
