module PhysiciansHelper
  def rate(physician)
    appoointments = Appointment.joins(:physician).where(physician_id: physician.id).where(state: 2).where.not(rate: nil).pluck(:rate)
    count = appoointments.count
    sum = appoointments.inject(0) { |sum, x| sum + x }
    return (sum / count).to_f unless count == 0
  end

  def complete_count(physician)
    return Appointment.where(physician_id: physician.id).where(state: 2).count
  end
end
