module Clearance
  module App
    module Controllers
      module PasswordsController

        def self.included(base)
          base.class_eval do
            before_filter :find_user_with_reset_password_code_or_deny, :only => [:edit, :update]
            filter_parameter_logging :password, :password_confirmation
            
            include InstanceMethods
            
          private
            include PrivateInstanceMethods
          end
        end

        module InstanceMethods
          def create
            user_as_entered = User.new params[:user]
            @user = user_as_entered
            
            failed_create('Enter an email address.') and return if user_as_entered.email.blank?
            
            found_user = User.find_by_email(user_as_entered.email)

            failed_create('Unknown email') and return if found_user.nil?
            
            if found_user.facebook_user?
              failed_create 'This is a Facebook account, please visit facebook.com to recover your password.'
              return
            end
            
            if found_user.confirmed?
              custom_validation_for_create_message = custom_validation_for_create(found_user)
              if custom_validation_for_create_message.blank?
                found_user.generate_reset_password_code
                ClearanceMailer.deliver_forgot_password found_user
                flash[:success] = "We sent you an email with instructions to reset your password."
                after_create_successful
                return
              else
                @user = user_as_entered
                failed_create(custom_validation_for_create_message)
                return
              end
            end
            
            failed_create('Sorry, this account is not active.')
          end

          def update
            if @user.reset_password(params)
              session[:user_id] = @user.id
              flash[:success] = "Your password has been updated."
              redirect_to url_after_update
            else
              flash.now[:error] = 'Password not changed.'
              render :action => :edit
            end
          end
        end

        module PrivateInstanceMethods
          def after_create_successful
            redirect_to url_after_create
          end
          
          # override this if you want to have additional constraints before sending password reset
          # example:  a security question must be answered
          def custom_validation_for_create(user)
          end
          
          def find_user_with_reset_password_code_or_deny
            @user = User.find_by_reset_password_code(params[:id])
            if @user.nil?
              render :nothing => true, :status => :not_found
            end
          end
          
          def url_after_create
            new_session_url
          end
          
          def url_after_update
            user_url(@user)
          end
          
          def failed_create(msg)
            flash[:error] = msg
            render :action => :new
          end
        end

      end
    end
  end
end
