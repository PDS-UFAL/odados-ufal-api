class AddAbbreviationToSector < ActiveRecord::Migration[6.1]
  def change
    add_column :sectors, :abbreviation, :string
  end
end
