class Service < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { only_integer: true }

  has_many :appointments, dependent: :destroy

  enum status: { inactive: 0, active: 1 }, _prefix: :status
end
