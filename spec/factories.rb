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
  user.association(:user_status)
end

Factory.define :family do |family|
  family.name { random_name }
end

Factory.define :role do |role|
  role.name { random_name }
end

Factory.define :user_status do |status|
  status.name "Alive"
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
# Schema version: 20090114001127
#
# Table name: user_statuses
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime