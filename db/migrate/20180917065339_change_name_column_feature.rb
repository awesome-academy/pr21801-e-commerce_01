class ChangeNameColumnFeature < ActiveRecord::Migration[5.1]
  def change
    rename_column :features, :RAM, :ram
    rename_column :features, :ROM, :rom
    rename_column :features, :Pin, :pin
    rename_column :features, :CPU, :cpu
  end
end
