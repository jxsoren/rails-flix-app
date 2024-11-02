class AddSlugToFlicks < ActiveRecord::Migration[7.0]
  def change
   add_column :flicks, :slug, :string  
  end
end
