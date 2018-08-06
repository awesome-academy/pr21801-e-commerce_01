class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.references :order
      t.references :product
      t.integer :quantity
      t.integer :price

      t.timestamps
    end
  end
end
