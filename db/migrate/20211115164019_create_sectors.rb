class CreateSectors < ActiveRecord::Migration[6.1]
  def change
    create_table :sectors do |t|
      t.string :name
      t.string :email
      t.string :responsible

      t.timestamps
    end
  end
end
