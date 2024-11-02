class ChangeNameToTitle < ActiveRecord::Migration[7.0]
  def change
    rename_column :flicks, :name, :title
  end
end
