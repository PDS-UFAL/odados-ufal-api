class AddSectorsIdToForm < ActiveRecord::Migration[6.1]
  def change
    add_column :forms, :sector_ids, :bigint, array: true, default: []
  end
end
