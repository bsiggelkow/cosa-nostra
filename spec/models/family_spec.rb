require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Family do
  table_has_columns(Family, :string, "name")
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