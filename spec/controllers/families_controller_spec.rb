require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe FamiliesController do
  route_matches("/families", :get, :controller => "families", :action => "index")
  route_matches("/families/1", :get, :controller => "families", :action => "show", :id => "1")
end
