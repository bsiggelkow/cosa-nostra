class User < ActiveRecord::Base
  include Clearance::App::Models::User
  
  attr_accessible :first_name, :last_name, :nickname
  
  validates_presence_of :first_name, :last_name, :role, :family
  
  belongs_to :family
  belongs_to :role
  belongs_to :user_status
  
  named_scope :alive, 
    :conditions => ["user_statuses.id = users.user_status_id AND user_statuses.name = 'Alive'"], 
    :include => :user_status
    
  named_scope :deceased, 
    :conditions => ["user_statuses.id = users.user_status_id AND user_statuses.name = 'Deceased'"], 
    :include => :user_status
    
  named_scope :ranked, 
    :order => "roles.name, user_statuses.name ASC", 
    :include => [:user_status, :role]
end
