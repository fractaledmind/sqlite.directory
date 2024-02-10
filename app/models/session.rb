class Session < ApplicationRecord
  COOKIE_KEY = :session_token

  belongs_to :user

  validates :user_agent, presence: true
  validates :ip_address, presence: true

  def self.find_by_encoded_id(identifier)
    find_by_id(identifier.to_i(36))
  end

  def encoded_id = id.to_s(36).rjust(10, "0")
end
