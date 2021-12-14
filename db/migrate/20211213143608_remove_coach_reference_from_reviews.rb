class RemoveCoachReferenceFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :coach_id, :references
  end
end
