class ClearanceGenerator < Rails::Generator::Base
  
  def manifest
    record do |m|
      m.directory File.join("app", "controllers")
      [
        "app/controllers/application.rb",
        "app/controllers/confirmations_controller.rb",
        "app/controllers/passwords_controller.rb", 
        "app/controllers/sessions_controller.rb", 
        "app/controllers/users_controller.rb"
      ].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "models")
      ["app/models/user.rb",
       "app/models/clearance_mailer.rb"].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "passwords")
      ["app/views/passwords/new.html.haml",
       "app/views/passwords/edit.html.haml"].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "sessions")
      ["app/views/sessions/new.html.haml"].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "clearance_mailer")
      [
        "app/views/clearance_mailer/confirmation.html.haml",
        "app/views/clearance_mailer/facebook_welcome.text.html.haml",
        "app/views/clearance_mailer/forgot_password.html.haml"
      ].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "users")
      ["app/views/users/_form.html.haml",
       "app/views/users/new.html.haml",
       "app/views/users/_password_form.html.haml",
       "app/views/users/edit_password.html.haml"].each do |file|
        m.file file, file
      end
      
      m.directory 'config/initializers'
      [
        "config/initializers/action_mailer.rb"
      ].each do |file|
        m.file file, file
      end
      
      m.directory 'public/images'
      [
        "public/images/connect_light_medium_long.gif"
      ].each do |file|
        m.file file, file
      end

      m.directory File.join("test", "functional")
      ["test/functional/confirmations_controller_test.rb",
       "test/functional/passwords_controller_test.rb",
       "test/functional/sessions_controller_test.rb",
       "test/functional/users_controller_test.rb"].each do |file|
        m.file file, file
      end
      
      m.directory File.join("test", "unit")
      ["test/unit/clearance_mailer_test.rb",
       "test/unit/user_test.rb"].each do |file|
        m.file file, file
      end
      
      ["test/factories.rb"].each do |file|
        m.file file, file
      end
    end
  end
  
end
