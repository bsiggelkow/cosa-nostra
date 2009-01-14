require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Role do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Role.create!(@valid_attributes)
  end
end


# == Schema Info
# Schema version: 20090114001127
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime