class RenameInitialDateToStartDateOnForm < ActiveRecord::Migration[6.1]
  def up
    rename_column :forms, :initial_date, :start_date
  end

  def down 
    rename_column :forms, :start_date, :initial_date
  end
end
