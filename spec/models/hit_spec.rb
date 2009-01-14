require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Hit do
  describe "state transitions" do
    before(:each) do
      @user = Factory :user
      @hit = Factory :hit, :target => @user, :assigned_to => @user
    end
    
    it "should start at unassigned" do
      @hit.unassigned?.should be_true
    end
    
    describe "accept" do
      it "should transition from unassigned to assigned" do
        @hit.accept!
        @hit.assigned?.should be_true
      end
    end
    
    describe "complete" do
      it "should transition from assigned to completed" do
        @hit.state = "assigned"
        @hit.complete!
        @hit.completed?.should be_true
      end
      
      it "should set the target user status to deceased" do
        @hit.state = "assigned"
        @hit.complete!
        @hit.target.should be_deceased
      end
    end
    
    describe "fail" do
      it "should transition from assigned to failed" do
        @hit.state = "assigned"
        @hit.fail!
        @hit.failed?.should be_true
      end
    end
    
    describe "reassign" do
      it "should transition from failed to assigned" do
        @hit.state = "failed"
        @hit.reassign!
        @hit.assigned?.should be_true
      end
    end
  end
end


# == Schema Info
# Schema version: 20090114013851
#
# Table name: hits
#
#  id          :integer(4)      not null, primary key
#  assigned_to :integer(4)
#  state       :string(255)
#  target      :integer(4)
#  created_at  :datetime
#  updated_at  :datetime