class CreateFormSends < ActiveRecord::Migration[6.1]
  def change
    create_table :form_sends do |t|
      t.datetime :end_date, null: false
      t.datetime :start_date, null: false
      t.integer :status, null: false, default: 1
      t.string :subtitle
      t.references :form, null: false, foreign_key: true

      t.timestamps
    end
  end
end
