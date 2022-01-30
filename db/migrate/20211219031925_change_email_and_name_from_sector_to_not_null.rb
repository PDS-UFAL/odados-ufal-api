class ChangeEmailAndNameFromSectorToNotNull < ActiveRecord::Migration[6.1]
  def up
    change_column :sectors, :name, :string, null: false
    change_column :sectors, :email, :string, null: false
  end

  def down
    change_column :sectors, :email, :string, null: true
    change_column :sectors, :name, :string, null: true
  end
end
