module Clearance
  module App
    module Models
      module User
        def self.included(base)
          base.class_eval do
            attr_accessor \
              :password,
              :password_confirmation,
              :old_password

            attr_accessible \
              :email,
              :password,
              :password_confirmation

            validates_presence_of   :email, :unless => :facebook_user?
            validates_uniqueness_of :email, :unless => :facebook_user?

            validates_presence_of     :password, :if => :password_required?
            validates_confirmation_of :password, :if => :password_required?

            before_save  :initialize_salt,            :unless => :facebook_user?
            before_save  :encrypt_password,           :unless => :facebook_user?
            after_create :generate_confirmation_code, :unless => :facebook_user?
        
            extend ClassMethods
            include InstanceMethods
        
          protected

            include ProtectedInstanceMethods
        
          end
        end
    
        module ClassMethods
          def authenticate(email, password)
            user = find_by_email email
            user && user.authenticated?(password) ? user : nil
          end
        end
    
        module InstanceMethods
          def authenticated?(password)
            crypted_password == encrypt(password)
          end

          def encrypt(password)
            Digest::SHA1.hexdigest "--#{salt}--#{password}--"
          end

          def remember_token?
            remember_token_expires_at && Time.now.utc < remember_token_expires_at
          end

          def remember_me!
            remember_me_until 2.weeks.from_now.utc
          end

          def remember_me_until(time)
            self.update_attribute :remember_token_expires_at, time
            self.update_attribute :remember_token, encrypt("#{email}--#{remember_token_expires_at}")
          end

          def forget_me!
            self.update_attribute :remember_token_expires_at, nil
            self.update_attribute :remember_token, nil
          end
        
          def confirm!
            self.update_attribute :confirmed, true
            update_attribute(:confirmation_code, nil)
          end
          
          def generate_confirmation_code
            update_attribute(:confirmation_code, Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join))
          end
          
          def generate_reset_password_code
            update_attribute(:reset_password_code, Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join))
          end
          
          def reset_password(password_hash)
            if update_attributes(password_hash.slice(:password, :password_confirmation))
              update_attribute(:reset_password_code, nil)
            end
          end
          
          def change_password(password_hash)
            if authenticated?(password_hash[:old_password])
              update_attributes(password_hash.slice(:password, :password_confirmation))
            else
              errors.add(:old_password, "does not match")
              return false
            end
          end
          
          def facebook_user?
            not normal_user?
          end

          def normal_user?
            self.respond_to?(:facebook_id) ? facebook_id.nil? : true
          end
        end
    
        module ProtectedInstanceMethods
          def initialize_salt
            self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
          end

          def encrypt_password
            return if password.blank?
            self.crypted_password = encrypt(password)
          end

          def password_required?
            normal_user? && (crypted_password.blank? || !password.blank? || !password_confirmation.blank?)
          end
        end
      end
    end
  end
end
