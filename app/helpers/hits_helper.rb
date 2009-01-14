module HitsHelper
  
  def can_issue_hit(current_user, target)
    current_user.has_permission?("Issue Hit") && target.target_hits.empty? && target.alive?
  end
  
end
