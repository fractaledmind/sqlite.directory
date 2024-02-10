class MakeUsersAvatarUrlNonNullable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :users, :avatar_url, false
  end
end
