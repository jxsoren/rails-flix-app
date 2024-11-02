class AddLookupCodeToGenre < ActiveRecord::Migration[7.0]
  def change
    add_column :genres, :lookup_code, :string
  end
end
