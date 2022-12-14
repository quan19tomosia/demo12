class Appointment < ApplicationRecord
  belongs_to :physician
  belongs_to :patient
  belongs_to :service

  enum state: {pending: 0, confirmed: 1, complete: 2, cancelled: 3}, _prefix: :state
end
