class CreateCharacterizations < ActiveRecord::Migration[7.0]
  def change
    create_table :characterizations do |t|
      t.references :flick, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
