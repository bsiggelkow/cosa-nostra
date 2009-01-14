boss_role = Factory :role, :name => "Boss"
mobster_role = Factory :role, :name => "Mobster"

bonanno_family = Factory :family, :name => "Bonanno"
gambino_family = Factory :family, :name => "Gambino"

issue_hit_permission = Factory :permission, :name => "Issue Hit", :role => boss_role
accept_hit_permission = Factory :permission, :name => "Accept Hit", :role => mobster_role
completed_hit_permission = Factory :permission, :name => "Hit Completed", :role => mobster_role
fail_hit_permission = Factory :permission, :name => "Hit Failed", :role => mobster_role

# Bonanno Family Members boss - Vincent Basciano
Factory :user, 
        :first_name => "Vincent",
        :nickname => "Vinny Gorgeous", 
        :last_name => "Basciano", 
        :email => "gorgeous@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => boss_role, 
        :family => bonanno_family

Factory :user, 
        :first_name => "Salvatore",
        :nickname => "Sal the Iron Worker", 
        :last_name => "Montagna", 
        :email => "sal@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family
        
Factory :user, 
        :first_name => "Nicholas",
        :nickname => "Nicky Mouth", 
        :last_name => "Santora", 
        :email => "mouth@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family

Factory :user, 
        :first_name => "Anthony",
        :nickname => "Fat Tony", 
        :last_name => "Rabito", 
        :email => "fattony@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family
        
Factory :user, 
        :first_name => "Michael",
        :nickname => "Mikey Nose", 
        :last_name => "Mancuso", 
        :email => "nose@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family

Factory :user, 
        :first_name => "Joseph",
        :nickname => "Joe Desi", 
        :last_name => "DeSimone", 
        :email => "desi@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family

Factory :user, 
        :first_name => "Anthony",
        :nickname => "Bruno", 
        :last_name => "Indelicato", 
        :email => "bruno@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family

Factory :user, 
        :first_name => "Anthony",
        :nickname => "T.G.", 
        :last_name => "Graziano", 
        :email => "tg@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family

Factory :user, 
        :first_name => "Louis",
        :nickname => "Louie Ha Ha", 
        :last_name => "Attanasio", 
        :email => "haha@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family        

Factory :user, 
        :first_name => "Peter",
        :nickname => "Rabbit", 
        :last_name => "Calabrese", 
        :email => "rabbit@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family 

Factory :user, 
        :first_name => "Nicolo",
        :nickname => "Nick", 
        :last_name => "Rizzuto", 
        :email => "nick@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family 

Factory :user, 
        :first_name => "Vittorio",
        :nickname => "Vito", 
        :last_name => "Rizzuto", 
        :email => "vito@bonanno.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => bonanno_family
        
# Gambino Family Members - boss 
Factory :user, 
        :first_name => "Nicholas", 
        :nickname => "Little Nick",
        :last_name => "Corozzo", 
        :email => "littlenick@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => boss_role, 
        :family => gambino_family
        
Factory :user, 
        :first_name => "Albert",
        :nickname => "Lord High Executioner", 
        :last_name => "Anastasia", 
        :email => "executioner@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

Factory :user, 
        :first_name => "Anthony",
        :nickname => "Tough Tony", 
        :last_name => "Anastasio", 
        :email => "toughtony@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

Factory :user, 
        :first_name => "Thomas",
        :last_name => "Bilotti", 
        :email => "bilotti@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family


Factory :user, 
        :first_name => "Paul",
        :nickname => "The Lawyer",
        :last_name => "Gotti", 
        :email => "thelawyer@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

Factory :user, 
        :first_name => "Roy",
        :last_name => "Demeo", 
        :email => "demeo@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

Factory :user, 
        :first_name => "Mickey",
        :nickname => "Mikey Scars",
        :last_name => "DiLeonardo", 
        :email => "scars@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family 
        
Factory :user, 
        :first_name => "Michael",
        :last_name => "Featherstone", 
        :email => "featherstone@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family       

Factory :user, 
        :first_name => "Thomas",
        :nickname => "Tommy",
        :last_name => "Gambino", 
        :email => "tommy@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

Factory :user, 
        :first_name => "John",
        :nickname => "Dapper Don",
        :last_name => "Gotti", 
        :email => "dapperdon@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

Factory :user, 
        :first_name => "John",
        :nickname => "Junior",
        :last_name => "Gotti, Jr.", 
        :email => "junior@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

Factory :user, 
        :first_name => "Salvator",
        :nickname => "Sammy the Bull",
        :last_name => "Gravano", 
        :email => "salvator@gambino.com", 
        :password => "password", 
        :password_confirmation => "password", 
        :role => mobster_role, 
        :family => gambino_family

