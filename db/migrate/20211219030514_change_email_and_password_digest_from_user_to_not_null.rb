class ChangeEmailAndPasswordDigestFromUserToNotNull < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :email, :string, null: false
    change_column :users, :password_digest, :string, null: false
  end

  def down
    change_column :users, :password_digest, :string, null: true
    change_column :users, :email, :string, null: true
  end
end
