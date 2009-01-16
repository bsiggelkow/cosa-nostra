require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  # the next few are macros defined in your spec_helper.rb file
  table_has_columns(User, :string, "first_name")
  requires_presence_of User, :role

  # these matchers come from the rspec-on-rails-matchers plugin
  it "should belong to a family" do
    User.should belong_to(:family)
  end
  
  it "should belong to a role"
  it "should have many target_hits"
  it "should have many assigned_hits"
  
  # normal rspec testing to follow
  describe "target_hit" do
    it "should return the first target hit"
  end
  
  describe "has_permission?" do
    it "should delegate to the role"
  end
  
  describe "kill!" do
    before(:each) do
      @user = Factory :user
    end
    
    it "should change the users state from alive to deceased" do
      @user.alive?.should be_true
      lambda {
        @user.kill!
      }.should change { @user.state }
      @user.deceased?.should be_true
    end
  end
  
  describe "alive?" do
    it "should return true if user status is alive"
  end
  
  describe "deceased?" do
    it "should return true if user status is deceased"
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
      it "should return all living users"
    end
    
    describe "deceased" do
      it "should return all deceased users"
    end
    
    describe "ranked" do
      before(:each) do
        @users = User.ranked
      end
      
      it "should sort living bosses first" do
        @users.first.role.name.should == "Boss"
        @users.first.should be_alive
      end
      
      it "should sort deceased bosses second"
      it "should sort living wise guys third"
      it "should sort deceased wise guys last"
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
    
    it "should require a last name"
    it "should require a role"
    it "should require a family"
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