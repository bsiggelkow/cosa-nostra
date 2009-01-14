require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Role do

  describe "has_permission?" do
    
    before(:each) do
      @role = Role.new
      @role.permissions.build(:name => "Test")
    end
    
    it "should return true if the role contains the supplied permission" do
      @role.has_permission?("Test").should be_true
    end
    
    it "should return false if the role does not contain the permission" do
      @role.has_permission?("Testing").should be_false
    end
    
  end
  
end

# == Schema Info
# Schema version: 20090114004000
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime