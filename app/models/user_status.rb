class UserStatus < ActiveRecord::Base
  def self.deceased
    return "Deceased"
  end
  
  def self.alive
    return "Alive"
  end
end


# == Schema Info
# Schema version: 20090114013851
#
# Table name: user_statuses
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime