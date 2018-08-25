class ChangeColumnNameRating < ActiveRecord::Migration[5.1]
  def change
    rename_column :ratings, :rating, :stars
  end
end
