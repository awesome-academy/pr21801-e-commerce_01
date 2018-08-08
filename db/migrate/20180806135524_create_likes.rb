class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :product
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
