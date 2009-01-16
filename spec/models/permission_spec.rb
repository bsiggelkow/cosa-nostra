require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Permission do
  table_has_columns(Permission, :string, "name")
  
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