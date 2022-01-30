class ChangeTitleAndTypeFromQuestionToNotNull < ActiveRecord::Migration[6.1]
  def up
    change_column :questions, :title, :string, null: false
    change_column :questions, :type, :string, null: false
  end

  def down
    change_column :questions, :type, :string, null: true
    change_column :questions, :title, :string, null: true
  end
end
