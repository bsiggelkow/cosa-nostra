class Permission < ActiveRecord::Base
  belongs_to :role
end


# == Schema Info
# Schema version: 20090114013851
#
# Table name: permissions
#
#  id         :integer(4)      not null, primary key
#  role_id    :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime