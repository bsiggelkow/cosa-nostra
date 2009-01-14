module HitsHelper
  
  def can_issue_hit(current_user, target)
    current_user.has_permission?("Issue Hit") && target.target_hits.empty? && target.alive? && target.family != current_user.family
  end
  
  def can_take_no_action(current_user, target)
    
  end
  
end
