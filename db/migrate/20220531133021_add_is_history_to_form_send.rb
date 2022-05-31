class AddIsHistoryToFormSend < ActiveRecord::Migration[6.1]
  def change
    add_column :form_sends, :is_history, :boolean
  end
end
