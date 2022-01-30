class CreateForms < ActiveRecord::Migration[6.1]
  def change
    create_table :forms do |t|
      t.string :title
      t.integer :status, null: false, default: 1
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
