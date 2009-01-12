module Clearance
  module Spec
    module Models
      module UserModel
        def self.included(base)
          base.class_eval do
            describe "normal vs. facebook users" do
              it "distinguishes normal user" do
                u = User.new
                u.facebook_id = nil
                u.should be_normal_user
                u.should_not be_facebook_user
              end

              it "distinguishes Facebook user" do
                u = User.new
                u.facebook_id = "something"
                u.should be_facebook_user
                u.should_not be_normal_user
              end
            end

            it "should be valid with just a facebook_id if user is a facebook user" do
              u = User.new
              u.facebook_id = "something"
              u.should be_valid
            end
          end
        end
      end
    end
  end
end
