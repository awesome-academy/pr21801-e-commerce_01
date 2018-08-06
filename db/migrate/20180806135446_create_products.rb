class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category
      t.integer :price
      t.text :description
      t.float :average_rating

      t.timestamps
    end
  end
end
