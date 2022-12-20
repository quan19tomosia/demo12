module AppointmentsHelper
  def states_collection
    return Appointment.states.map { |k,v| [k.humanize.capitalize, v] }.push(["All states", ""]).reverse
  end

  def badge_class(state)
    case state
    when 'pending'
      return 'warning'
    when 'confirmed'
      return 'primary'
    when 'complete'
      return 'success'
    when 'cancelled'
      return 'danger'
    else
      return 'info'
    end
  end
end
