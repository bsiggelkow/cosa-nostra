class User < ActiveRecord::Base
  
  include Clearance::App::Models::User
  
  attr_accessible :first_name, :last_name, :nickname
  
  validates_presence_of :first_name, :last_name, :role, :family
  
  belongs_to :family
  belongs_to :role
  
end


# == Schema Info
# Schema version: 20090112233422
#
# Table name: users
#
#  id                        :integer(4)      not null, primary key
#  family_id                 :integer(4)
#  confirmation_code         :string(255)
#  confirmed                 :boolean(1)      not null
#  crypted_password          :string(40)
#  email                     :string(255)
#  first_name                :string(255)
#  last_name                 :string(255)
#  remember_token            :string(255)
#  reset_password_code       :string(255)
#  salt                      :string(40)
#  remember_token_expires_at :datetime