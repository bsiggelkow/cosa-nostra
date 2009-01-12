set :application, "application_name"
set :repository,  "git@github.com:hashrocket/application_name.git"
set :scm, :git

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

role :app, "your app-server here"
role :web, "your web-server here"
role :db,  "your db-server here", :primary => true
