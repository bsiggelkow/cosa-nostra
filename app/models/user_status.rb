class UserStatus < ActiveRecord::Base
end


# == Schema Info
# Schema version: 20090114001127
#
# Table name: user_statuses
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime