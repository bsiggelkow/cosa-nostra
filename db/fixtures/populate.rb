boss_role = Factory :role, :name => "Boss"
wise_guy_role = Factory :role, :name => "Wise Guy"

family_one = Factory :family, :name => "Family 1"
family_two = Factory :family, :name => "Family 2"

Factory :user, :first_name => "Bob", :last_name => "Bobby", :email => "bob@example.com", :password => "password", :password_confirmation => "password", :role => boss_role, :family => family_one
Factory :user, :first_name => "Bob2", :last_name => "Bobby2", :email => "bob2@example.com", :password => "password", :password_confirmation => "password", :role => wise_guy_role, :family => family_one

