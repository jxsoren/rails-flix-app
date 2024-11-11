class RemoveImageFileNameFromFlicks < ActiveRecord::Migration[7.0]
  def change
    remove_column :flicks, :image_file_name, :string
  end
end
