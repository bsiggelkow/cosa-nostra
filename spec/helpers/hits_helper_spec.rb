require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HitsHelper do
  
  describe "can_fail_hit?" do
    
    before(:each) do
      @current_user = stub_model(User)
      @current_user.expects(:has_permission?).with("Hit Failed").returns(true)
    end
          
    describe "when target is alive" do
      
      before(:each) do
        @target = stub_model(User)
      end
      
      describe "when current user is assigned to the hit" do
        it "should return true if target has a hit issued on them in assigned state"
        it "should return false if target has a hit issued on them not in assigned state"
      end
    end
    
    describe "when target is dead" do
    
      it "should return false at all times"
    end
  
  end
  
  describe "can_complete_hit?" do
    
    before(:each) do
      @current_user = stub_model(User)
      @current_user.expects(:has_permission?).with("Hit Completed").returns(true)
    end
          
    describe "when target is alive" do

      describe "when current user is assigned to the hit" do
        it "should return true if target has a hit issued on them in assigned state"
        it "should return false if target has a hit issued on them not in assigned state"
      
      end
    end
    
    describe "when target is dead" do
      
      before(:each) do
        @target = stub_model(User)
      end
      
      it "should return false at all times" do
        @target.expects(:alive?).returns(false)
        helper.can_complete_hit?(@current_user, @target).should be_false
      end
    end
  
  end
  
  describe "can_accept_hit?" do
    
    before(:each) do
      @current_user = stub_model(User)
      @current_user.expects(:has_permission?).with("Accept Hit").returns(true)
    end
          
    describe "when target is alive" do
      describe "when target is from a different family" do
        it "should return true if target has a hit issued on them in unassigned state"
        it "should return false if target has a hit issued on them not in unassigned state"
      
      end
    end
    
    describe "when target is dead" do
      it "should return false at all times"
    end
  
  end
  
  describe "can_issue_hit?" do
    
    before(:each) do
      @current_user = stub_model(User)
      @current_user.expects(:has_permission?).with("Issue Hit").returns(true)
    end
          
    describe "when target is alive" do
      
      before(:each) do
        @target = stub_model(User)
      end
      
      describe "when target is from a different family" do
        
        before(:each) do
          @capone = stub_model(Family, :name => "Capone")
          @gotti = stub_model(Family, :name => "Gotti")
        end
      
        it "should return true if target has no hits issued on them" do
          @current_user.expects(:family).returns(@capone)
          @target.expects(:family).returns(@gotti)
          @target.expects(:alive?).returns(true)
          @target.expects(:target_hits).returns([])
          helper.can_issue_hit?(@current_user, @target).should be_true
        end
      
        it "should return false if targte has a hit issued on them"
      
      end
    end
    
    describe "when target is dead" do
      it "should return false at all times"
    end
    
    describe "when target is from the same family" do
      
      it "should return false at all times" 
      
    end
      
  end
  
end
