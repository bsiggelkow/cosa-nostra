module HitsHelper
  
  def can_issue_hit?(current_user, target)
    current_user.has_permission?("Issue Hit") && target.target_hits.empty? && target.alive? && target.family != current_user.family
  end
  
  def can_accept_hit?(current_user, target)
    current_user.has_permission?("Accept Hit") && target.alive? && target.target_hits.any? && target.target_hit.unassigned? && target.family != current_user.family
  end
  
  def can_complete_hit?(current_user, target)
    current_user.has_permission?("Hit Completed") && target.alive? && target.target_hits.any? && target.target_hit.assigned? && target.target_hit.assigned_to == current_user
  end
  
  def can_fail_hit?(current_user, target)
    current_user.has_permission?("Hit Failed") && target.alive? && target.target_hits.any? && target.target_hit.assigned? && target.target_hit.assigned_to == current_user
  end
  
end
