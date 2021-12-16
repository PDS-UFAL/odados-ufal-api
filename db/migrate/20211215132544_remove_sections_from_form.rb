class RemoveSectionsFromForm < ActiveRecord::Migration[6.1]
  def up
    remove_column :forms, :sections
    
  end

  def down 
    add_column :forms, :sections, :jsonb
  end
end
