require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HitsController do

  describe "new" do
    before(:each) do
      @hit = Hit.new
      @target = Factory :user
    end
    
    it "should set the target on the hit" do
      Hit.expects(:new).returns(@hit)
      User.expects(:find_by_id).with("1").returns(@target)
      @hit.expects(:target=).with(@target)
      get :new, :target_id => "1"
    end  
  end
  
end
