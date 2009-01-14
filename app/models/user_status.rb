class UserStatus < ActiveRecord::Base
  
  def self.deceased
    return "Deceased"
  end
  
  def self.alive
    return "Alive"
  end
  
end
