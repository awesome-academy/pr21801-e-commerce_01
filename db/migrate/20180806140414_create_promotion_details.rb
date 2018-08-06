class CreatePromotionDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :promotion_details do |t|
      t.references :product
      t.references :promotion
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
