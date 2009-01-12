module Clearance
  module App
    module Models
      module ClearanceMailer
    
        def self.included(base)
          base.class_eval do
        
            include InstanceMethods
        
          end
        end
    
        module InstanceMethods
          def forgot_password(user)
            from       DO_NOT_REPLY
            recipients user.email
            subject    "[#{PROJECT_NAME.humanize}] Forgot your password"
            body       :user => user
          end
        
          def confirmation(user)
            recipients user.email
            from       DO_NOT_REPLY
            subject   "[#{PROJECT_NAME.humanize}] Account confirmation"
            body      :user => user
          end
        end
        
      end
    end
  end
end
