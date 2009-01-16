class Role < ActiveRecord::Base
  has_many :permissions
  
  def has_permission?(name)
    return permissions.map(&:name).include?(name)
  end
end

# == Schema Info
# Schema version: 20090114222108
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime