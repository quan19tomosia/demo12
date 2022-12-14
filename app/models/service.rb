class Service < ApplicationRecord
  has_many :appointments, dependent: :destroy

  enum status: { inactive: 0, active: 1 }, _prefix: :status
end
