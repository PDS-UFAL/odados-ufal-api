class ChangeNameFromSectionToNotNull < ActiveRecord::Migration[6.1]
  def up
    change_column :sections, :name, :string, null: false
  end

  def down
    change_column :sections, :name, :string, null: true
  end
end
