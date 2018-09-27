class AddColumnToFeature < ActiveRecord::Migration[5.1]
  def change
    add_reference :features, :product, foreign_key: true
  end
end
