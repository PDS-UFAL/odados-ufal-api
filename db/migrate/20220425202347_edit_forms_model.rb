class EditFormsModel < ActiveRecord::Migration[6.1]
  def change
    remove_column :forms, :end_date, :datetime
    remove_column :forms, :start_date, :datetime
    remove_column :forms, :status, :integer
    add_column :forms, :description, :string
  end
end
