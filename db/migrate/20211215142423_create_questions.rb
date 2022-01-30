class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :type
      t.boolean :required
      t.integer :max_char
      t.integer :max_value
      t.integer :min_value
      t.string :options, array: true, default: []
      t.references :section, null: false, foreign_key: true

      t.timestamps
    end
  end
end
