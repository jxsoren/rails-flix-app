class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :name
      t.integer :stars
      t.text :comment
      t.references :flick, null: false, foreign_key: true

      t.timestamps
    end
  end
end
