class ChangeFieldNameStartsAt < ActiveRecord::Migration[7.0]
  def change
    rename_column :flicks, :starts_at, :released_on
  end
end
