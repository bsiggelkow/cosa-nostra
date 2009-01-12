module Clearance
  module Spec
    module Controllers
      module PasswordsController
        def self.included(base)
          base.class_eval do
            include ActionController::UrlWriter
            
            describe "#create when called for a facebook user" do
              before(:each) do
                @user = stub(:facebook_user? => true, :generate_reset_password_code => nil)
                User.stubs(:find_by_email).returns(@user)
                ClearanceMailer.stubs(:deliver_forgot_password)
              end
              
              it "should assign an error message" do
                @controller.instance_eval{flash.stubs(:sweep)}
                post :create
                flash.now[:error].should be
              end
              
              it "should render the new template" do
                post :create
                response.should render_template('new')
              end
            end
            
            describe "#create when called for a normal user that is unconfirmed" do
              before(:each) do
                @user = stub(:facebook_user? => false, :confirmed? => false, :generate_reset_password_code => nil)
                User.stubs(:find_by_email).returns(@user)
                ClearanceMailer.stubs(:deliver_forgot_password)
              end
              
              it "should assign an error message" do
                @controller.instance_eval{flash.stubs(:sweep)}
                post :create
                flash.now[:error].should be
              end
              
              it "should render the new template" do
                post :create
                response.should render_template('new')
              end
            end
            
          end
        end
      end
    end
  end
end
            