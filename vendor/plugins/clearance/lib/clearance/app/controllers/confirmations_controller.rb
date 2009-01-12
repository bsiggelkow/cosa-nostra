module Clearance
  module App
    module Controllers
      module ConfirmationsController
    
        def self.included(base)
          base.class_eval do
            include InstanceMethods
        
          private
            include PrivateInstanceMethods
          end
        end
    
        module InstanceMethods
          def confirm
            user = User.find_by_confirmation_code(params[:confirmation_code])
            if user.nil?
              render(:nothing => true, :status => :not_found) and return
            end
            user.confirm!
            login(user)
            redirect_to url_after_confirm
          end
        end
    
        module PrivateInstanceMethods
          def url_after_confirm
            root_url
          end
        end
    
      end
    end
  end
end