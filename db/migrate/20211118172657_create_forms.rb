class CreateForms < ActiveRecord::Migration[6.1]
  def change
    create_table :forms do |t|
      t.jsonb :questions
      t.string :title
      t.date :initial_date
      t.date :end_date

      t.timestamps
    end
  end
end
