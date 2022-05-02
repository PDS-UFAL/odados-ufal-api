class AddFsendToResponses < ActiveRecord::Migration[6.1]
  def change
    add_column :responses, :fsend, :bigint
  end
end
