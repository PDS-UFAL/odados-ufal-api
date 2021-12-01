class CreateSectorsFormsJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :forms, :sectors do |t|
      t.index :form_id
      t.index :sector_id
    end
  end
end
