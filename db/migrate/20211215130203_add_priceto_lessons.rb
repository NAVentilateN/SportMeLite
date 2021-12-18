class AddPricetoLessons < ActiveRecord::Migration[6.1]
  def change
    add_monetize :lessons, :price, currency: { present: false }
  end
end
