require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserStatus do
  table_has_columns(UserStatus, :string, "name")
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