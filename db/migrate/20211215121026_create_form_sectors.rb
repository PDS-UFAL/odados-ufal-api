class CreateFormSectors < ActiveRecord::Migration[6.1]
  def change
    create_table :form_sectors do |t|
      t.references :form, null: false, foreign_key: true
      t.references :sector, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
