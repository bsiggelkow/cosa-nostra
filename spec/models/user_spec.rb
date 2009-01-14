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
    
    it "should require a role" do
      @user.errors.should be_invalid(:role)
    end
    
    it "should require a family" do
      @user.errors.should be_invalid(:family)
    end
    
  end

end


# == Schema Info
# Schema version: 20090112233422
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  family_id                 :integer(4)
#  confirmation_code         :string(255)
#  confirmed                 :boolean(1)      not null
#  crypted_password          :string(40)
#  email                     :string(255)
#  first_name                :string(255)
#  last_name                 :string(255)
#  remember_token            :string(255)
#  reset_password_code       :string(255)
#  salt                      :string(40)
#  remember_token_expires_at :datetime