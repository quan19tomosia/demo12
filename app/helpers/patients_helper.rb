module PatientsHelper
  def last_visit(patient)
    last_visit = Appointment.where(patient_id: patient.id).where(state: 2).order(schedule: :desc).pluck(:schedule).first
    return last_visit ? last_visit.strftime("%d-%m-%Y") : "N/A"
  end
end
