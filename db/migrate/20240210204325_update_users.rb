class UpdateUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :github_uid, :string, null: false, index: { unique: true }
    add_column :users, :github_username, :string, null: false
    add_column :users, :twitter_username, :string
    remove_column :users, :email, :string
  end
end
