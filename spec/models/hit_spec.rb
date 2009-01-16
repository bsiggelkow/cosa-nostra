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
      it "should transition from unassigned to assigned"
    end
    
    describe "assign" do
      before(:each) do
        @user = stub_model(User)
      end
      
      it "should accept and assign the user to the hit"
    end
    
    describe "complete" do
      it "should transition from assigned to completed"
      it "should set the target user status to deceased"
    end
    
    describe "fail" do
      it "should transition from assigned to failed"
    end
    
    describe "reassign" do
      it "should transition from failed to assigned"
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