require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  
  describe "validation" do
    
    before(:each) do
      @user = User.new
      @user.valid?
    end
    
    it "should require a first name" do
      @user.errors.should be_invalid(:first_name)
    end
    
    it "should require a last name" do
      @user.errors.should be_invalid(:last_name)
    end
    
  end

end
