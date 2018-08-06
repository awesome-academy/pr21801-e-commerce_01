class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.text :content
      t.integer :percent

      t.timestamps
    end
  end
end
