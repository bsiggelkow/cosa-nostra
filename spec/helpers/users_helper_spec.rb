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
      it "should return the users killer"
    end
    
  end

end
