class SessionsController < ApplicationController
  include Clearance::App::Controllers::SessionsController  
  include Clearance::App::Controllers::FacebookSessionsController
  
  facebook_to_user_field_mappings \
    :first_name => :first_name,
    :last_name => :last_name
end
