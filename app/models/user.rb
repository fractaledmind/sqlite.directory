class User < ApplicationRecord
  has_many :sessions, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :github_uid, presence: true, uniqueness: true
  validates :github_username, presence: true
end
