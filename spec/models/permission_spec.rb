require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Permission do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Permission.create!(@valid_attributes)
  end
end


# == Schema Info
# Schema version: 20090114004000
#
# Table name: permissions
#
#  id         :integer(4)      not null, primary key
#  role_id    :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime