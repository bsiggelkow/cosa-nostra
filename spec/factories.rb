require "factory_girl"

Factory.define :user do |user|
  user.email { random_email_address }
  user.first_name "John"
  user.last_name "Gotti"
  user.password "password"
  user.password_confirmation "password"
  user.confirmed true
  user.association(:role)
  user.association(:family)
end

Factory.define :family do |family|
  family.name { random_name }
end

Factory.define :role do |role|
  role.name { random_name }
end

def random_email_address
  "#{random_string}@example.com"
end

def random_name
  random_string
end

def random_string
  letters = *'a'..'z'
  random_string_for_uniqueness = ''
  10.times { random_string_for_uniqueness += letters[rand(letters.size - 1)]}
  random_string_for_uniqueness
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