class Appointment < ApplicationRecord
  require 'csv'

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["Patient", "Physician", "Service", "Schedule", "Note", "State", "Rate", "Comment"]
      all.each do |appoinment|
        csv << [appoinment.patient.user.name, appoinment.physician.user.name, appoinment.service.name, appoinment.schedule, appoinment.note, appoinment.state.capitalize, appoinment.rate, appoinment.comment]
      end
    end
  end

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
