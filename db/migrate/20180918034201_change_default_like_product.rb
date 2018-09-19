class ChangeDefaultLikeProduct < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :likes_count, :integer, default: 0
  end
end
