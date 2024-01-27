class Entry < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  validate :at_least_one_use

  attribute :uses, type: Array, default: []

  def at_least_one_use
    errors.add(:uses, :at_least_one) if uses.all?(&:empty?)
  end
end
