ActionController::Routing::Routes.draw do |map|
  
  map.resources :users
  map.resource :session
  map.resources :users, :has_one => :password
  map.resources :users, :has_one => :confirmation
  map.resources :passwords
  map.resources :families
  map.resources :hits
  
  map.root :controller => 'sessions', :action => 'new'
  
  map.confirmations '/confirmations/:confirmation_code', :controller => 'confirmations', :action => 'confirm', :conditions => {:method => :get}
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
