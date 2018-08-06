class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user
      t.integer :total
      t.boolean :status

      t.timestamps
    end
  end
end
