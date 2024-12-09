class UsersGitHubUsernamesAreUnique < ActiveRecord::Migration[8.0]
  def change
    add_index :users, :github_username, unique: true
  end
end
