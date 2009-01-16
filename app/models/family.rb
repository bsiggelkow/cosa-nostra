class Family < ActiveRecord::Base
  has_many :users
end

# == Schema Info
# Schema version: 20090114222108
#
# Table name: families
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime