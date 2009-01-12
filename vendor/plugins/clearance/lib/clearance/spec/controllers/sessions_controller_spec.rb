module Clearance
  module Spec
    module Controllers
      module SessionsController
        def self.included(base)
          base.class_eval do
            include ActionController::UrlWriter
            
            describe "#facebook_new" do
              it "should redirect to facebook login url" do
                get :facebook_new
                response.should redirect_to(Facebooker.login_url_base)
              end
  
              it "should redirect to facebook create if the user is already authenticated with facebook" do
                controller.stubs(:ensure_authenticated_to_facebook).returns(true)
                get :facebook_new
                response.should redirect_to(facebook_create_session_url)
              end
            end

            describe "#facebook_create" do
              before(:each) do
                controller.stubs(:ensure_authenticated_to_facebook).returns(true)
                @facebook_user = stub('facebook_user', :facebook_id => 1, :first_name => 'Johnny', :last_name => 'McLovin', :birthday => 'today', :id => 1)
                User.stubs(:find_by_facebook_id).returns(@facebook_user)
                @facebook_session = stub_everything('facebook_session', :user => @facebook_user)
                controller.stubs(:facebook_session).returns(@facebook_session)
              end
  
              it "should get the facebook id from the session" do
                controller.stubs(:redirect_back_or_default)
                # @facebook_session.stubs(:user).returns(@facebook_user)
                @facebook_user.expects(:facebook_id).returns(1)
                get :facebook_create
              end
  
              it "should try to find a user by their facebook id" do
                controller.stubs(:redirect_back_or_default)
                session[:facebook_session] = stub_everything('facebook_session', :facebook_id => 1)
                User.expects(:find_by_facebook_id).with(1).returns(@facebook_user)
                get :facebook_create
              end
  
              it "should set the current user" do
                controller.stubs(:redirect_back_or_default)
                controller.expects(:login).with(@facebook_user)
                get :facebook_create
              end
  
              it "should call redirect_back_or_default" do
                get :facebook_create
                response.should be_redirect
              end

              describe "when user doesn't exist on our system" do
                before :each do
                  controller.stubs(:redirect_back_or_default)
                  @facebook_user.stubs(:send_email)
                  @facebook_session.stubs(:user).returns(@facebook_user)
                  User.stubs(:find_by_facebook_id).returns(nil)
                  @user = stub_everything("User")
                end
    
                it "creates a user if one cannot be found" do
                  User.expects(:new).returns(@user)
                  get :facebook_create
                end
  
                it "sets the first name, last name, facebook id on the new user" do
                  User.stubs(:create!).yields(@user).returns(@user)
                  @user.expects(:first_name=).with('Johnny')
                  @user.expects(:last_name=).with('McLovin')
                  @user.expects(:facebook_id=).with(1)
                  get :facebook_create
                end

                it "activates the new user" do
                  get :facebook_create
                  saved_user = User.last
                  saved_user.should be_confirmed
                end

                describe "Facebook user welcome email" do
                  it "contains a link to the home page URL" do
                    @user = stub("User", :email => "lark@example.com")
                    mail = ClearanceMailer.create_facebook_welcome(@user)
                    mail.body.should =~ /#{root_url}/
                  end
      
                  it "sets the subject, body and sends email" do
                    mail = stub("Mail", :subject => "some subject", :body => "some text")
                    ClearanceMailer.stubs(:create_facebook_welcome).returns(mail)
                    @facebook_user.expects(:send_email).with("some subject", "some text")
                    get :facebook_create
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
