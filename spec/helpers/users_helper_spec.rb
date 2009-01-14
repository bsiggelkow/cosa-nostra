require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersHelper do
  
  describe "status" do
    
    describe "when user is alive" do
      before(:each) do
        @user = stub_model(User)
        @user.expects(:alive?).returns(true)
        @user.expects(:state).returns("Test")
      end
      
      it "should return the user status" do
        helper.status(@user).should == "Test"
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
