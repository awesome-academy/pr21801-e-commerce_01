class CreateFeatures < ActiveRecord::Migration[5.1]
  def change
    create_table :features do |t|
      t.text :screen
      t.text :camera
      t.text :CPU
      t.string :RAM
      t.string :ROM
      t.string :Pin

      t.timestamps
    end
  end
end
