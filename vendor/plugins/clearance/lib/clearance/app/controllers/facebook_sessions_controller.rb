module Clearance
  module App
    module Controllers
      module FacebookSessionsController
        def self.included(base)
          base.class_eval do
            include Facebooker::Rails::Controller
            before_filter :ensure_authenticated_to_facebook, :only => %w(facebook_new facebook_create)
            
            include InstanceMethods
            extend ClassMethods
            
            class_inheritable_hash :_facebook_to_user_field_mappings
          end
        end
        
        module InstanceMethods
          def facebook_new
            # handle the case where ensure_authenticated_to_facebook filter passes through,
            # like when the user has already authenticated and we have the facebook cookies
            redirect_to facebook_create_session_url
          end

          def facebook_create
            facebook_user = facebook_session.user
            facebook_id = facebook_user.facebook_id

            user = User.find_by_facebook_id(facebook_id)

            unless user
              user = User.create! do |u|
                u.facebook_id = facebook_id
                u.confirmed = true
                
                if _facebook_to_user_field_mappings
                  _facebook_to_user_field_mappings.each do |facebook_field, user_field|
                    u.send("#{user_field}=", facebook_user.send(facebook_field))
                  end
                end
              end

              mail = ClearanceMailer.create_facebook_welcome(user)
              facebook_user.send_email(mail.subject, mail.body)   
            end

            login user
            redirect_back_or root_url
          end
        end # InstanceMethods
        
        module ClassMethods
          def facebook_to_user_field_mappings(mappings = {})
            self._facebook_to_user_field_mappings = mappings
          end
        end #ClassMethods        
      end # FacebookSessionsController
    end
  end
end
