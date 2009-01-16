require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Role do
  table_has_columns(Role, :string, "name")
  
  describe "has_permission?" do
    before(:each) do
      @role = Role.new
      @role.permissions.build(:name => "Test")
    end
    
    it "should return true if the role contains the supplied permission"
    it "should return false if the role does not contain the permission"
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