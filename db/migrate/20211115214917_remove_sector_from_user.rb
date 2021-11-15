class RemoveSectorFromUser < ActiveRecord::Migration[6.1]
  def up
    remove_column :users, :sector
  end

  def down
    add_column :users, :sector, :string
  end
end
