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

Factory.define :boss do |user|
  user.email { random_email_address }
  user.first_name "John"
  user.last_name "Gotti"
  user.password "password"
  user.password_confirmation "password"
  user.confirmed true
  user.association(:boss_role)
  user.association(:family)
  user.association(:user_status)
end

Factory.define :mobster do |user|
  user.email { random_email_address }
  user.first_name "John"
  user.last_name "Gotti"
  user.password "password"
  user.password_confirmation "password"
  user.confirmed true
  user.association(:mobster_role)
  user.association(:family)
  user.association(:user_status)
end

Factory.define :permission do |permission|
  permission.name { random_name }
  permission.association(:role)
end

Factory.define :family do |family|
  family.name { random_name }
end

Factory.define :role do |role|
  role.name { random_name }
end

Factory.define :boss_role do |role|
  role.name "boss"
end

Factory.define :mobster_role do |role|
  role.name "mobster"
end

Factory.define :user_status do |user_status|
  user_status.name "Alive"
end

Factory.define :hit do |hit|
  hit.association(:target)
  hit.association(:assigned_to)
end

Factory.define :assigned_to do |user|
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

Factory.define :target do |user|
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
