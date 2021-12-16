class AddStatusToForm < ActiveRecord::Migration[6.1]
  def change
    add_column :forms, :status, :integer, null: false, default: 1
  end
end
