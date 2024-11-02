class CreateFlicks < ActiveRecord::Migration[7.0]
  def change
    create_table :flicks do |t|
      t.string :name
      t.string :rating
      t.decimal :total_gross

      t.timestamps
    end
  end
end
