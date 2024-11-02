class AddRatingAndDecimalToFlicks < ActiveRecord::Migration[7.0]
  def change
    add_column :flicks, :rating, :string
    add_column :flicks, :total_gross, :decimal
  end
end
