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
    end
    
    it "should set the target on the hit" do
      Hit.expects(:new).returns(@hit)
      User.expects(:find_by_id).with("1").returns(@target)
      @hit.expects(:target=).with(@target)
      get :new, :target_id => "1"
    end  
  end
  
  describe "create" do
    before(:each) do
      @hit = stub_model(Hit)
      @hit_method = stub_model(HitMethod)
      @params = { :hit => { :hit_method => @hit_method, :target_id => "1", :deadline => "2009-05-05" } }
      HitMethod.expects(:find_by_id).returns(@hit_method)
    end
    
    it "should create the new hit" do
      Hit.expects(:create).returns(@hit)
      post :create, @params
    end
    
    it "should redirect to the family detail page of the target" do
      Hit.expects(:create).returns(@hit)
      @hit.expects(:target).returns(@user)
      post :create, @params
      response.should redirect_to(family_path(@family))
    end
  end
  
  
  describe "accept" do
    before(:each) do
      @user = stub_model(User)
      @hit = stub_model(Hit)
      @params = { :id => "1" }
      Hit.expects(:find_by_id).with("1").returns(@hit)
    end
    
    it "should call assign on the hit" do
      controller.expects(:current_user).returns(@user)
      @hit.expects(:assign).with(@user)
      get :accept, @params
    end
    
  end

  describe "complete" do
    before(:each) do
      @hit = stub_model(Hit, :state => "accepted")
      @params = { :id => "1" }
      Hit.expects(:find_by_id).with("1").returns(@hit)
    end
    
    it "should call complete on the hit" do
      @hit.expects(:complete!)
      get :complete, @params
    end
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
