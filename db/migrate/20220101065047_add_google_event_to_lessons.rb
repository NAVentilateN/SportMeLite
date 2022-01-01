class AddGoogleEventToLessons < ActiveRecord::Migration[6.1]
  def change
    add_column :lessons, :google_event_id, :string
  end
end
