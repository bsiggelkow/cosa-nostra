require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  table_has_columns(User, :string, "first_name")
  table_has_columns(User, :string, "last_name")
  table_has_columns(User, :string, "nickname")
  table_has_columns(User, :integer, "role_id")
  table_has_columns(User, :integer, "family_id")
  
  requires_presence_of User, :role
  requires_presence_of User, :family
  requires_presence_of User, :first_name
  requires_presence_of User, :last_name
  
  describe "has_permission?" do
    before(:each) do
      @role = stub_model(Role)
      @user = User.new
      @user.role = @role
    end
    
    it "should delegate to the role" do
      @role.expects(:has_permission?).with("Test").returns(true)
      @user.has_permission?("Test").should be_true
    end
  end
  
  describe "kill!" do
    before(:each) do
      @user = Factory :user
    end
    
    it "should change the users state from alive to deceased" do
      @user.alive?.should be_true
      @user.kill!
      @user.deceased?.should be_true
    end
  end
  
  describe "alive?" do
    before(:each) do
      @user = Factory :user
    end
    
    it "should return true if user status is alive" do
      @user.alive?.should be_true
    end
  end
  
  describe "deceased?" do
    before(:each) do
      @user = Factory :user
      @user.kill!
    end
    
    it "should return true if user status is deceased" do
      @user.deceased?.should be_true
    end
  end

  describe "named_scopes" do
    before(:each) do
      Factory :user, :role => (Factory :role, :name => "Boss")
      (Factory :user, :role => (Factory :role, :name => "Mobsters")).kill!
      Factory :user, :role => (Factory :role, :name => "Mobsters")
      Factory :user, :role => (Factory :role, :name => "Mobsters")
      (Factory :user, :role => (Factory :role, :name => "Boss")).kill!
    end
    
    describe "alive" do
      it "should return all living users" do
        User.alive.count.should == 3
      end
    end
    
    describe "deceased" do
      it "should return all deceased users" do
        User.deceased.count.should == 2
      end
    end
    
    describe "ranked" do
      before(:each) do
        @users = User.ranked
      end
      
      it "should sort living bosses first" do
        @users.first.role.name.should == "Boss"
        @users.first.should be_alive
      end
      
      it "should sort deceased bosses second" do
        @users[1].role.name.should == "Boss"
        @users[1].should be_deceased
      end
      
      it "should sort living wise guys third" do
        @users[2].role.name.should == "Mobsters"
        @users[2].should be_alive
      end
      
      it "should sort deceased wise guys last" do
        @users.last.role.name.should == "Mobsters"
        @users.last.should be_deceased
      end
    end
  end
  
  describe "validation" do
    before(:each) do
      @user = User.new
      @user.valid?
    end
    
    it "should require a first name" do
      @user.errors.should be_invalid(:first_name)      
      # different way to write the same thing. This way is a little more descriptive
      @user.should have(1).error_on(:first_name)
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
# Schema version: 20090114013851
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  family_id                 :integer(4)
#  role_id                   :integer(4)
#  user_status_id            :integer(4)
#  confirmation_code         :string(255)
#  confirmed                 :boolean(1)      not null
#  crypted_password          :string(40)
#  email                     :string(255)
#  first_name                :string(255)
#  last_name                 :string(255)
#  nickname                  :string(255)
#  remember_token            :string(255)
#  reset_password_code       :string(255)
#  salt                      :string(40)
#  remember_token_expires_at :datetime