class AddSlugToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :slug, :string
    add_column :products, :slug, :string
    add_index :categories, :slug
    add_index :products, :slug
  end
end
