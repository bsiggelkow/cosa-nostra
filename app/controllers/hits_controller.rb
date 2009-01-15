class HitsController < ApplicationController
  
  before_filter :load_hit, :except => [:new, :create]
  
  def new
    @hit = Hit.new
    @hit.target = User.find_by_id(params[:target_id])
  end
    
  def create
    params[:hit][:hit_method] = HitMethod.find_by_id(params[:hit][:hit_method])
    @hit = Hit.create(params[:hit])
  end
  
  def accept
    @hit.assign(current_user)
  end
  
  def complete
    @hit.complete!
  end
  
  def fail
    @hit.fail!
  end
  
  response_for :create, :accept, :complete, :fail do |format| 
    format.html do
      redirect_to family_path(@hit.target.family)
    end
  end
  
  private
    def load_hit
      @hit = Hit.find_by_id(params[:id])
    end
end
