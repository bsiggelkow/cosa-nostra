module Clearance
  module Test
    module Unit
      module UserTest
    
        def self.included(base)
          base.class_eval do
            should_require_attributes :email, :password
            should_have_instance_methods :old_password, :old_password=

            should "require password validation on create" do
              user = Factory.build(:user, :password => 'blah', :password_confirmation => 'boogidy')
              assert !user.save
              assert_match(/confirmation/i, user.errors.on(:password))
            end

            should "create a crypted_password on save" do
              assert_not_nil Factory(:user, :crypted_password => nil).crypted_password
            end
            
            should "generate a confirmation_code after create" do
              assert_not_nil Factory(:user, :password => 'boogidy', :password_confirmation => 'boogidy').confirmation_code
            end

            context 'updating a password' do
              setup do
                @user = Factory(:user)
                assert_not_nil @user.crypted_password
                @crypt = @user.crypted_password
                assert_not_nil @user.salt
                @salt = @user.salt
                @user.password = 'a_new_password'
                @user.password_confirmation = 'a_new_password'
                assert @user.save
              end

              should 'update a crypted_password' do
                @user.reload
                assert @user.crypted_password != @crypt
              end
            end
        
            context 'A user' do
              setup do
                @salt = 'salt'
                User.any_instance.stubs(:initialize_salt)
                @user = Factory :user, :salt => @salt
                @password = @user.password
              end
          
              should "require password validation on update" do
                @user.update_attributes(:password => "blah", :password_confirmation => "boogidy")
                assert !@user.save
                assert_match(/confirmation/i, @user.errors.on(:password))
              end
          
              should_require_unique_attributes :email
          
              context 'authenticating a user' do
                context 'with good credentials' do
                  setup do
                    @result = User.authenticate @user.email, @password
                  end

                  should 'return true' do
                    assert @result
                  end
                end

                context 'with bad credentials' do
                  setup do
                    @result = User.authenticate @user.email, 'horribly_wrong_password'
                  end

                  should 'return false' do
                    assert !@result
                  end
                end
              end
          
              context 'authenticated?' do
                context 'with good credentials' do
                  setup do
                    @result = @user.authenticated? @password
                  end

                  should 'return true' do
                    assert @result
                  end
                end

                context 'with bad credentials' do
                  setup do
                    @result = @user.authenticated? 'horribly_wrong_password'
                  end

                  should 'return false' do
                    assert !@result
                  end
                end
              end

              context 'encrypt' do
                setup do
                  @crypted  = @user.encrypt(@password)
                  @expected = Digest::SHA1.hexdigest("--#{@salt}--#{@password}--")
                end

                should 'create a Hash using SHA1 encryption' do
                  assert_equal @expected, @crypted
                  assert_not_equal @password, @crypted
                end
              end

              context 'remember_me!' do
                setup do
                  assert_nil @user.remember_token
                  assert_nil @user.remember_token_expires_at
                  @user.remember_me!
                end

                should 'set the remember token and expiration date' do
                  assert_not_nil @user.remember_token
                  assert_not_nil @user.remember_token_expires_at
                end

                should 'remember_token?' do
                  assert @user.remember_token?
                end

                context 'forget_me!' do
                  setup do
                    @user.forget_me!
                  end

                  should 'unset the remember token and expiration date' do
                    assert_nil @user.remember_token
                    assert_nil @user.remember_token_expires_at
                  end

                  should 'not remember_token?' do
                    assert ! @user.remember_token?
                  end
                end
              end

              context 'remember_token?' do
                context 'when token expires in the future' do
                  setup do
                    @user.update_attribute :remember_token_expires_at, 2.weeks.from_now.utc
                  end

                  should 'be true' do
                    assert @user.remember_token?
                  end
                end

                context 'when token expired' do
                  setup do
                    @user.update_attribute :remember_token_expires_at, 2.weeks.ago.utc
                  end

                  should 'be false' do
                    assert ! @user.remember_token?
                  end
                end
              end

              context "User.authenticate with a valid email and password" do
                setup do
                  @found_user = User.authenticate @user.email, @user.password
                end

                should "find that user" do
                  assert_equal @user, @found_user
                end
              end

              context "When sent authenticate with an invalid email and password" do
                setup do
                  @found_user = User.authenticate "not", "valid" 
                end

                should "find nothing" do
                  assert_nil @found_user
                end
              end
            end

            context "A user" do
              setup do
                @user = Factory :user
              end
              
              context 'when sent #generate_confirmation_code' do
                setup do
                  @user = Factory.build(:user)
                  assert ! @user.confirmed?
                  assert_nil @user.confirmation_code
                  @user.generate_confirmation_code
                end
                
                should 'generate a confirmation code' do
                  assert @user.confirmation_code
                end
                
                should 'not be confirmed' do
                  assert ! @user.confirmed?
                end
              end
              
              context 'when sent #confirm!' do
                setup do
                  assert ! @user.confirmed?
                  @user.generate_confirmation_code
                  assert @user.confirm!
                  @user.reload
                end

                should 'mark the User record as confirmed' do
                  assert @user.confirmed?
                end
                
                should 'remove the confirmation code' do
                  assert_nil @user.confirmation_code
                end
              end

              context 'when sent #generate_reset_password_code' do
                setup do
                  assert_nil @user.reset_password_code
                  @user.generate_reset_password_code
                end
                
                should 'generate a reset password code' do
                  assert @user.reset_password_code
                end
              end
              
              context 'when sent #reset_password' do
                setup do
                  assert_not_nil @user.crypted_password
                  assert_nil @user.reset_password_code
                  @user.generate_reset_password_code
                end
                
                should 'change the password when passed a matching password and confirmation password' do
                  old_pass = @user.crypted_password
                  @user.reset_password(:password => 'new_password', :password_confirmation => 'new_password')
                  assert_not_equal old_pass, @user.crypted_password
                end
                
                should 'return true if the password is changed' do
                  assert_equal true, @user.reset_password(:password => 'new_password', :password_confirmation => 'new_password')
                end

                should 'clear the reset_password_code after changing the password' do
                  @user.reset_password(:password => 'new_password', :password_confirmation => 'new_password')
                  assert_nil @user.reset_password_code
                end
                
                should 'return nil if the password is not confirmed' do
                  assert_nil @user.reset_password(:password => 'new_password', :password_confirmation => 'xnew_password')
                end
                
                should 'not validate if only the confirmation password is passed in' do
                  @user.reset_password(:password => '', :password_confirmation => 'new_password')
                  assert @user.errors.on(:password)
                end

                should 'not validate without a password to confirm' do
                  @user.reset_password(:password_confirmation => 'new_password')
                  assert @user.errors.on(:password)
                end

                should 'not validate if only the password is passed in' do
                  @user.reset_password(:password => 'new_password')
                  assert @user.errors.on(:password)
                end

                should 'not validate if the password is not confirmed' do
                  @user.reset_password(:password => 'new_password', :password_confirmation => 'xnew_password')
                  assert @user.errors.on(:password)
                end
              end

              context 'when sent #change_password' do
                 setup do
                   assert_not_nil @user.crypted_password
                 end

                 should 'change the password when passed an old password and matching password and confirmation password' do
                   old_pass = @user.crypted_password
                   @user.change_password(:old_password => 'password', :password => 'new_password', :password_confirmation => 'new_password')
                   assert_not_equal old_pass, @user.crypted_password
                 end

                 should 'return true if the password is changed' do
                   assert_equal true, @user.change_password(:old_password => 'password', :password => 'new_password', :password_confirmation => 'new_password')
                 end

                 should 'return false and not be valid if the old_password does not match' do
                   assert ! @user.change_password(:old_password => 'something_else', :password => 'new_password', :password_confirmation => 'new_password')
                   assert @user.errors.on(:old_password)
                 end

                 should 'return false and not be valid if only the confirmation password is passed in' do
                   assert ! @user.change_password(:old_password => 'password', :password => '', :password_confirmation => 'new_password')
                   assert @user.errors.on(:password)
                 end

                 should 'return false and not be valid without a password to confirm' do
                   assert ! @user.change_password(:old_password => 'password', :password_confirmation => 'new_password')
                   assert @user.errors.on(:password)
                 end

                 should 'return false and not be valid if only the password is passed in' do
                   assert ! @user.change_password(:old_password => 'password', :password => 'new_password')
                   assert @user.errors.on(:password)
                 end

                 should 'return false and not be valid if the password is not confirmed' do
                   assert ! @user.change_password(:old_password => 'password', :password => 'new_password', :password_confirmation => 'xnew_password')
                   assert @user.errors.on(:password)
                 end
               end

            end
          end
        end

      end
    end
  end
end
