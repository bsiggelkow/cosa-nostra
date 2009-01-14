require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  describe "named_scopes" do
    before(:each) do
      @living = Factory :user_status, :name => "Alive"
      @deceased = Factory :user_status, :name => "Deceased"
      Factory :user, :user_status => @living, :role => (Factory :role, :name => "Boss")
      Factory :user, :user_status => @deceased, :role => (Factory :role, :name => "Mobsters")
      Factory :user, :user_status => @living, :role => (Factory :role, :name => "Mobsters")
      Factory :user, :user_status => @living, :role => (Factory :role, :name => "Mobsters")
      Factory :user, :user_status => @deceased, :role => (Factory :role, :name => "Boss")
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
        @users.first.user_status.name.should == "Alive"
      end
      
      it "should sort deceased bosses second" do
        @users[1].role.name.should == "Boss"
        @users[1].user_status.name.should == "Deceased"
      end
      
      it "should sort living wise guys third" do
        @users[2].role.name.should == "Mobsters"
        @users[2].user_status.name.should == "Alive"
      end
      
      it "should sort deceased wise guys last" do
        @users.last.role.name.should == "Mobsters"
        @users.last.user_status.name.should == "Deceased"
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
