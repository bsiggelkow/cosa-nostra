module UsersHelper
  
  def status(user)
    return user.state if user.alive?
    return "Killed by #{user.target_hits.first.assigned_to.full_name}"
  end
  
end