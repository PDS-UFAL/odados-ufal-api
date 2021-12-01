class ChangeFormJsonbNameToSections < ActiveRecord::Migration[6.1]
  def up
    rename_column :forms, :questions, :sections
  end

  def down 
    rename_column :forms, :sections, :questions
  end
end
