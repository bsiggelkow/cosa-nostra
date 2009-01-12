ActionController::Routing::Routes.draw do |map|

  map.resources :users, :member => { :edit_password => :get, :change_password => :put }
  map.resources :passwords

  map.confirmations '/confirmations/:confirmation_code', :controller => 'confirmations', :action => 'confirm', :conditions => {:method => :get}

  map.resource :session, :member => { :facebook_new => :get, :facebook_create => :get }

  map.root :controller => 'users', :action => 'new'

end
