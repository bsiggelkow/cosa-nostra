class SessionsController < ApplicationController
  include Clearance::App::Controllers::SessionsController
  
  def login_successful
    redirect_to families_path
  end
  
end
