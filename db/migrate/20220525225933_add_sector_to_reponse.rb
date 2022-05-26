class AddSectorToReponse < ActiveRecord::Migration[6.1]
  def change
    add_reference :responses, :sector, foreign_key: true
  end
end
