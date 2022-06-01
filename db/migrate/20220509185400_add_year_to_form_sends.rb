class AddYearToFormSends < ActiveRecord::Migration[6.1]
  def change
    add_column :form_sends, :year, :integer, null: false, default: 2022
  end
end
