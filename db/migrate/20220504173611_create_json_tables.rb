class CreateJsonTables < ActiveRecord::Migration[6.1]
  def change
    create_table :json_tables do |t|
      t.json :json_file

      t.timestamps
    end
  end
end
