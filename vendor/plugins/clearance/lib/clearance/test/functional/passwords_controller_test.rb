module Clearance
  module Test
    module Functional
      module PasswordsControllerTest

        def self.included(base)
          base.class_eval do

            should_route :get, '/passwords/new', :action => 'new'
            should_route :post, '/passwords', :action => 'create'
            should_route :get, '/passwords/:id/edit', :action => 'edit', :id => 'reset_password_code'
            should_route :put, '/passwords/:id', :action => 'update', :id => 'reset_password_code'

            context 'with a user' do
              setup { @user = Factory :user, :confirmed => true }

              context 'A GET to #new' do
                setup { get :new }

                should_respond_with :success
                should_render_template 'new'
                
                should "have a form for the user's email" do
                  new_path = ERB::Util.h(passwords_path)

                  assert_select 'form[action=?]', new_path do
                    assert_select 'input[name=?]', 'email'
                  end
                end
                
              end

              context 'A POST to #create' do
                context "with an existing user's email address" do
                  setup do
                    ActionMailer::Base.deliveries.clear

                    post :create, :user => {:email => @user.email}
                    @email = ActionMailer::Base.deliveries[0]
                  end

                  should 'send an email to the user to edit their password' do
                    assert @email.subject =~ /forgot your password/i
                  end
                  
                  should 'generate a reset_password_code' do
                    @user.reload
                    assert_not_nil @user.reset_password_code
                  end

                  should_redirect_to "@controller.send(:url_after_create)"
                end

                context 'with a non-existing email address' do
                  setup do
                    email = 'user1@example.com'
                    assert ! User.exists?(['email = ?', email])
                    ActionMailer::Base.deliveries.clear

                    post :create, :user => {:email => email}
                  end

                  should 'not send a password reminder email' do
                    assert ActionMailer::Base.deliveries.empty?
                  end

                  should 'set a :error flash' do
                    assert_not_nil flash.now[:error]
                  end

                  should_render_template "new"
                end
              end

              context 'A GET to #edit' do
                context "with an existing user's reset password code" do
                  setup do
                    @user.generate_reset_password_code
                    get :edit, :id => @user.reset_password_code 
                  end

                  should 'find the user' do
                    assert_equal @user, assigns(:user)
                  end

                  should_respond_with :success
                  should_render_template "edit"

                  should "have a form for the user's email, password, and password confirm" do
                    update_path = ERB::Util.h(password_path(:id => @user.reset_password_code))

                    assert_select 'form[action=?]', update_path do
                      assert_select 'input[name=_method][value=?]', 'put'
                      assert_select 'input[name=?]', 'password'
                      assert_select 'input[name=?]', 'password_confirmation'
                    end
                  end
                end

                context "without an existing user's reset password code" do
                  setup do
                    get :edit, :id => 'some_random_x'
                  end

                  should_respond_with :not_found

                  should 'render an empty response' do
                    assert @response.body.blank?
                  end
                end
              end

              context 'A PUT to #update' do
                setup do
                  @new_password = 'new_password'
                  @encrypted_new_password = Digest::SHA1.hexdigest("--#{@user.salt}--#{@new_password}--")
                  assert_not_equal @encrypted_new_password, @user.crypted_password
                  @user.generate_reset_password_code
                end
                
                context "without an existing user's reset_password_code" do
                  setup do
                    put(:update,
                        :id => 'x',
                        :password => @new_password,
                        :password_confirmation => @new_password)
                    @user.reload
                  end

                  should "not find the user" do
                    assert_nil assigns[:user]
                  end

                  should_return_from_session :user_id, "nil"

                  should 'not remove the reset_password_code' do
                    assert_not_nil @user.reset_password_code
                  end
                  
                  should_respond_with :not_found

                  should 'render an empty response' do
                    assert @response.body.blank?
                  end
                end

                context 'with an existing user with a matching password and password confirmation' do
                  setup do
                    put(:update,
                        :id  => @user.reset_password_code,
                        :password              => @new_password,
                        :password_confirmation => @new_password)
                    @user.reload
                  end

                  should "update the user's password" do
                    assert_equal @encrypted_new_password, @user.crypted_password
                  end

                  should 'remove the reset_password_code' do
                    assert_nil @user.reset_password_code
                  end

                  should_return_from_session :user_id, "@user.id"

                  should_redirect_to "user_path(@user)"
                end

                context 'with blank password and a password confirmation' do
                  setup do
                    put(:update,
                        :id => @user.reset_password_code,
                        :password => '',
                        :password_confirmation => @new_password)
                    @user.reload
                  end

                  should "not update the user's password" do
                    assert_not_equal @encrypted_new_password, @user.crypted_password
                  end

                  should_return_from_session :user_id, "nil"

                  should 'set a :error flash' do
                    assert_not_nil flash.now[:error]
                  end

                  should_render_template "edit"
                end

                context 'with password but blank password confirmation' do
                  setup do
                    put(:update,
                        :id => @user.reset_password_code,
                        :password => @new_password,
                        :password_confirmation => '')
                    @user.reload
                  end

                  should "not update the user's password" do
                    assert_not_equal @encrypted_new_password, @user.crypted_password
                  end

                  should_return_from_session :user_id, "nil"

                  should 'not remove the reset_password_code' do
                    assert_not_nil @user.reset_password_code
                  end

                  should 'set a :error flash' do
                    assert_not_nil flash.now[:error]
                  end

                  should_render_template "edit"
                end
              end
            end
          end
        end

      end
    end
  end
end
