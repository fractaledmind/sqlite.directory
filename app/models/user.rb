class User < ApplicationRecord
  validates :github_uid, presence: true, uniqueness: true
  validates :github_username, presence: true
end
