class HitsController < ApplicationController
  resources_controller_for :hit
  
  def new
    @hit = Hit.new
    @hit.target = User.find_by_id(params[:target_id])
  end
  
end
