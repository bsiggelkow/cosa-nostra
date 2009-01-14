require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersHelper do
  
  describe "status" do
    
    describe "when user is alive" do
      before(:each) do
        @status = stub_model(UserStatus)
        @status.expects(:name).at_least(1).returns("Test")
        @user = stub_model(User)
        @user.user_status = @status
        @user.expects(:alive?).returns(true)
        @user.expects(:current_status).returns(@status)
      end
      
      it "should return the user status" do
        helper.status(@user).should == @user.current_status.name
      end
    end
    
    describe "when user is dead" do
      before(:each) do
        @hit = stub_model(Hit)
        @assigned = stub_model(User)
        @assigned.expects(:full_name).returns("Test User")
        @hit.expects(:assigned_to).returns(@assigned)
        @user = stub_model(User)
        @user.expects(:alive?).returns(false)
        @user.expects(:target_hits).returns([@hit])
      end
      
      it "should return the users killer" do
        helper.status(@user).should == "Killed by Test User"
      end
    end
    
  end

end
