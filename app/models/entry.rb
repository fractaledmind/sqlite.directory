class Entry < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true, http_url: true
  validate :at_least_one_use

  attribute :uses, type: Array, default: []

  def self.uses = %w[ persistence queue cache pubsub ]
  def self.hosts = %w[ DigitalOcean Hetzner Fly Render Vultr AWS GCP Azure ]
  def self.operating_systems = %w[ Ubuntu MacOS Windows Fedora Debian CentOS ]

  private

  def at_least_one_use
    errors.add(:uses, :at_least_one) if uses.all?(&:empty?)
  end
end
