class Appointment < ApplicationRecord
  attr_accessor :schedule_day, :schedule_time

  belongs_to :physician
  belongs_to :patient
  belongs_to :service

  before_validation do
    self.schedule = DateTime.parse([self.schedule_day, self.schedule_time].join(" ")) if self.schedule_day.present?
  end
  
  validates :service, presence: true
  validates :physician, presence: true
  validates :patient, presence: true

  enum state: {pending: 0, confirmed: 1, complete: 2, cancelled: 3}, _prefix: :state
end
