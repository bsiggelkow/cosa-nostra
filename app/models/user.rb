class User < ActiveRecord::Base
  
  include Clearance::App::Models::User
  
  attr_accessible :first_name, :last_name
  
  validates_presence_of :first_name, :last_name
  
  belongs_to :family
  belongs_to :role
  
end
