class User < ActiveRecord::Base
  include Clearance::App::Models::User
  
  attr_accessible :first_name, :last_name, :nickname, :state
  
  validates_presence_of :first_name, :last_name, :role, :family
  
  belongs_to :family
  belongs_to :role

  has_many :target_hits, :foreign_key => "target_id", :class_name => "Hit"
  has_many :assigned_hits, :foreign_key => "assigned_to"
  
  delegate  :has_permission?, :to => :role
  acts_as_state_machine :initial => :alive
  
  state :alive 
  state :deceased 
  
  event :kill do
    transitions :from => :alive, :to => :deceased
  end

  named_scope :alive, 
    :conditions => {:state => 'alive'} 
    
  named_scope :deceased, 
    :conditions => {:state => "deceased"}
    
  named_scope :ranked, 
    :order => "roles.name, state ASC", 
    :include => [:role]
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def target_hit
    return target_hits.first
  end
  
end

# == Schema Info
# Schema version: 20090114222108
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  family_id                 :integer(4)
#  role_id                   :integer(4)
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
#  state                     :string(255)
#  remember_token_expires_at :datetime