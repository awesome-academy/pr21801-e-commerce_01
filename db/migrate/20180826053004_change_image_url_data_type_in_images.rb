class ChangeImageUrlDataTypeInImages < ActiveRecord::Migration[5.1]
  def change
    change_column :images, :image_url, :string
  end
end
