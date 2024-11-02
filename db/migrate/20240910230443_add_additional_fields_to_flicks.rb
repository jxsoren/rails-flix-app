class AddAdditionalFieldsToFlicks < ActiveRecord::Migration[7.0]
  def up
    add_column :flicks, :director, :string
    add_column :flicks, :duration, :string
    add_column :flicks, :image_file_name, :string, default: "placeholder.png"
  end

  def down
    remove_column :flicks, :director, :string
    remove_column :flicks, :duration, :string
    remove_column :flicks, :image_file_name, :string
  end
end
