module Clearance
  module Test
    module Unit
      module ClearanceMailerTest
  
        def self.included(base)
          base.class_eval do
            context "A forgot password email" do
              setup do
                @user = Factory :user
                @user.generate_reset_password_code
                @email = ClearanceMailer.create_forgot_password @user
              end

              should "set its from address to DO_NOT_REPLY" do
                assert_equal DO_NOT_REPLY, @email.from[0]
              end

              should "contain a link to edit the user's password" do
                host = ActionMailer::Base.default_url_options[:host]
                regexp = %r{http://#{host}/passwords/#{@user.reset_password_code}}
                assert_match regexp, @email.body
              end

              should "be sent to the user" do
                assert_equal [@user.email], @email.to
              end

              should "have a subject of '[PROJECT_NAME] Forgot your password'" do
                assert_equal @email.subject, "[#{PROJECT_NAME.humanize}] Forgot your password"
              end
            end
            
            context "A confirmation email" do
              setup do
                @user = Factory :user
                @user.generate_confirmation_code
                @email = ClearanceMailer.create_confirmation @user
              end

              should 'set its recipient to the given user' do
                assert_equal @user.email, @email.to[0]
              end

              should 'set its subject' do
                assert_equal "[#{PROJECT_NAME.humanize}] Account confirmation", @email.subject
              end

              should 'set its from address to DO_NOT_REPLY' do
                assert_equal DO_NOT_REPLY, @email.from[0]
              end

              should "contain a link to confirm the user's account" do
                host = ActionMailer::Base.default_url_options[:host]
                regexp = %r{http://#{host}/confirmations/#{@user.confirmation_code}}
                assert_match regexp, @email.body
              end
            end
          end
        end

      end
    end  
  end
end
