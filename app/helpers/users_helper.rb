module UsersHelper
  def role_collection
    User.roles.map{ |k,v| [k.humanize.capitalize, v] }.push(["All roles", ""]).reverse
  end

  def role_badge_class(role)
    case role
    when 'admin'
      return 'dark'
    when 'physician'
      return 'info'
    when 'patient'
      return 'primary'
    end
  end

  def lock_badge_class(lock)
    lock ? "danger" : "success"
  end
end
