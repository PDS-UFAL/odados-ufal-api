class RemoveFormIdFromFormSectors < ActiveRecord::Migration[6.1]
  def change
    remove_reference :form_sectors, :form, foreign_key: true
    add_reference :form_sectors, :form_send, foreign_key: true
  end
end