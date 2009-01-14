class HitsController < ApplicationController
  resources_controller_for :hit
  
  def new
    @hit = Hit.new
    @hit.target = User.find_by_id(params[:target_id])
  end
  
  
  def create
    params[:hit][:hit_method] = HitMethod.find_by_id(params[:hit][:hit_method])
    @hit = Hit.create(params[:hit])
  end
  
  response_for :create do |format| 
    format.html do
      redirect_to family_path(@hit.target.family)
    end
  end
end
