class AddDescriptionAndStartsAtToFlicks < ActiveRecord::Migration[7.0]
  def change
    add_column :flicks, :description, :string
    add_column :flicks, :starts_at, :datetime
  end
end
