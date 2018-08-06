class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :image
      t.text :description
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id

      t.timestamps
    end
  end
end
