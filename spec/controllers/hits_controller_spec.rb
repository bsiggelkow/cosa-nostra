require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe HitsController do
  
  before(:each) do
    @family = stub_model(Family)
    @user = stub_model(User, :family => @family)
  end

  describe "new" do
    before(:each) do
      @hit = stub_model(Hit)
      @target = stub_model(User)
      @params = { :target_id => "1" }
    end
    
    it "should set the correct target on the hit" do
      Hit.expects(:new).returns(@hit)
      User.expects(:find_by_id).with("1").returns(@target)
      get :new, @params
      @hit.target.should == @target
    end
  end
  
  describe "create" do
    it "should create the new hit"
    it "should redirect to the family detail page of the target"
  end
  
  
  describe "accept" do
    it "should call assign on the hit"
  end

  describe "complete" do
    it "should call complete on the hit"
  end
  
  describe "fail" do
    before(:each) do
      @hit = stub_model(Hit, :state => "accepted")
      @params = { :id => "1" }
      Hit.expects(:find_by_id).with("1").returns(@hit)
    end
    
    it "should call fail on the hit" do
      @hit.expects(:fail!)
      get :fail, @params
    end
  end
  
  
end
