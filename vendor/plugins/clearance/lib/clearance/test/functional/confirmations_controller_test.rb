module Clearance
  module Test
    module Functional
      module ConfirmationsControllerTest

        def self.included(base)
          base.class_eval do

            context 'A GET to #confirm' do
              context "with the User's given confirmation code" do
                setup do
                  @user = Factory :user
                  @user.generate_confirmation_code
                  get :confirm, :confirmation_code => @user.confirmation_code
                  @user.reload
                end

                should 'find and confirm the User record with the given confimation code' do
                  assert @user.confirmed?
                end

                should_return_from_session :user_id, "@user.id"

                should_respond_with :redirect
                should_redirect_to "@controller.send(:url_after_confirm)"
                
              end

              context "without the User's given confirmation code" do
                setup do
                  user = Factory :user
                  get :confirm, :confirmation_code => ''
                end

                should_respond_with :not_found

                should 'render nothing' do
                  assert @response.body.blank?
                end
              end
              
            end

          end
        end

      end
    end
  end
end
