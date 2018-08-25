class ChangeTypeStarAverage < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :average_rating, :integer, default: 0
    change_column :ratings, :stars, :integer
  end
end
