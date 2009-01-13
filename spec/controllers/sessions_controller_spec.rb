require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SessionsController do
  
  before(:each) do
    @user = stub_model(User)
    @user.expects(:confirmed?).returns(true)
    @params = { :session => { :email => "test@example.com", :password => "password" } }
  end
  
  describe "login_successful" do
    
    before(:each) do
      User.expects(:authenticate).with(@params[:session][:email], @params[:session][:password]).returns(@user)
    end
    
    it "should redirect to the families path" do
      post :create, @params
      response.should redirect_to(families_path)
    end
    
  end
  
end