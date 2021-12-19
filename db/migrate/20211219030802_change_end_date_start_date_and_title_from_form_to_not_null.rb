class ChangeEndDateStartDateAndTitleFromFormToNotNull < ActiveRecord::Migration[6.1]
  def up
    change_column :forms, :end_date, :datetime, null: false
    change_column :forms, :start_date, :datetime, null: false
    change_column :forms, :title, :string, null: false
  end

  def down
    change_column :forms, :title, :string, null: true
    change_column :forms, :start_date, :datetime, null: true
    change_column :forms, :end_date, :datetime, null: true
  end
end
