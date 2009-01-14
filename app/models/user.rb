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
    
  def alive?
    return user_status.name == UserStatus.alive
  end
  
  def deceased?
    return user_status.name == UserStatus.deceased
  end
  
end


# == Schema Info
# Schema version: 20090114013851
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  family_id                 :integer(4)
#  role_id                   :integer(4)
#  user_status_id            :integer(4)
#  confirmation_code         :string(255)
#  confirmed                 :boolean(1)      not null
#  crypted_password          :string(40)
#  email                     :string(255)
#  first_name                :string(255)
#  last_name                 :string(255)
#  nickname                  :string(255)
#  remember_token            :string(255)
#  reset_password_code       :string(255)
#  salt                      :string(40)
#  remember_token_expires_at :datetime