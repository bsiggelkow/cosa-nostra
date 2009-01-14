require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HitsHelper do
  
  describe "can_take_no_action" do
    
    describe "when target is alive" do
      
      describe "when target has no hit" do
        
      end
      
      describe "when target has a hit" do
        
        describe "when hit is unassigned" do
          
        end
        
        describe "when hit is assigned" do
          
        end
        
        describe "when hit is complete" do
          
        end
        
        describe "when hit is failed" do
          
        end
        
      end
      
    end
    
    describe "when target is deceased" do
      
    end
  end
  
  describe "can_issue_hit" do
    
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
          helper.can_issue_hit(@current_user, @target).should be_true
        end
      
        it "should return false if targte has a hit issued on them" do
          @target.expects(:target_hits).returns(["test"])
          helper.can_issue_hit(@current_user, @target).should be_false
        end
      
      end
    end
    
    describe "when target is dead" do
      
      before(:each) do
        @target = stub_model(User)
      end
      
      it "should return false at all times" do
        @target.expects(:alive?).returns(false)
        @target.expects(:target_hits).returns([])
        helper.can_issue_hit(@current_user, @target).should be_false
      end
    end
    
    describe "when target is from the same family" do
      
      before(:each) do
        @capone = stub_model(Family, :name => "Capone")
      end
      
      it "should return false at all times" do
        @current_user.expects(:family).returns(@capone)
        @target.expects(:family).returns(@capone)
        @target.expects(:alive?).returns(true)
        @target.expects(:target_hits).returns([])
        helper.can_issue_hit(@current_user, @target).should be_false
      end
      
    end
      
  end
  
end
