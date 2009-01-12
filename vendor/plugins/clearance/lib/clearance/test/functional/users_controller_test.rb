module Clearance
  module Test
    module Functional
      module UsersControllerTest

        def self.included(base)
          base.class_eval do
            public_context do

              context "on GET to /users/new" do
                setup { get :new }
                should_respond_with :success
                should_render_template :new
                should_not_set_the_flash
                should_have_form :action => "users_path",
                  :method => :post,
                  :fields => { :email => :text,
                    :password => :password,
                    :password_confirmation => :password }

                context "with params" do
                  setup do
                    @email = 'a@example.com'
                    get :new, :user => {:email => @email}
                  end

                  should_assign_to :user
                  should "set the @user's params" do
                    assert_equal @email, assigns(:user).email
                  end
                end
              end

              context "on POST to /users" do
                setup do
                  @email = Factory.next(:email)
                  post :create, :user => {
                    :email => @email,
                    :password => 'skerit',
                    :password_confirmation => 'skerit'
                  }
                end
            
                should_set_the_flash_to /confirm/i
                should_redirect_to "@controller.send(:url_after_create)"
                should_assign_to :user
                should_change 'User.count', :by => 1
                
                should 'have a confirmation code' do
                  assert_not_nil User.find_by_email(@email).confirmation_code
                end
              end

            end

            logged_in_user_context do
              context "GET to new" do
                setup { get :new }
                should_render_template 'new'
              end

              context "POST to create" do
                setup { post :create, :user => {} }
                should_render_template 'new'
              end

              should_filter_params :password
            end
            
            public_context do
              context 'A GET to #edit_password when not logged in' do
                setup do
                  @user = Factory(:user)
                  @user.confirm!
                  get :edit_password, :id => @user.id
                end
                
                should_respond_with :redirect

                should_redirect_to "new_session_path"
              end

              context 'A PUT to #change_password when not logged in' do
                setup do
                  @user = Factory(:user)
                  @user.confirm!
                  @new_password = 'new_password'
                  put(:change_password,
                      :id  => @user.id,
                      :user => { :old_password => 'password',
                      :password => @new_password,
                      :password_confirmation => @new_password })
                end

                should_respond_with :redirect

                should_redirect_to "new_session_path"
              end
            end
            
            logged_in_user_context do
              context 'A GET to #edit_password' do
                setup do
                  @user.confirm!
                  get :edit_password, :id => @user.id
                end

                should 'find the user' do
                  assert_equal @user, assigns(:user)
                end

                should_respond_with :success
                should_render_template "edit_password"

                should "have a form for the user's email, password, and password confirm" do
                  update_path = ERB::Util.h(change_password_user_path(:id => @user))

                  assert_select 'form[action=?]', update_path do
                    assert_select 'input[name=_method][value=?]', 'put'
                    assert_select 'input[name=?][type=password]', 'user[old_password]'
                    assert_select 'input[name=?]', 'user[password]'
                    assert_select 'input[name=?]', 'user[password_confirmation]'
                  end
                end
              end

              context 'A PUT to #change_password' do
                setup do
                  @user.confirm!
                  @new_password = 'new_password'
                  @encrypted_new_password = Digest::SHA1.hexdigest("--#{@user.salt}--#{@new_password}--")
                  assert_not_equal @encrypted_new_password, @user.crypted_password
                end

                context 'with an existing user with a matching password and password confirmation' do
                  setup do
                    put(:change_password,
                        :id  => @user.id,
                        :user => { :old_password => 'password',
                        :password => @new_password,
                        :password_confirmation => @new_password })
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

                context 'with a blank old_password' do
                  setup do
                    put(:change_password,
                        :id => @user.id,
                        :user => {:old_password => '',
                        :password => @new_password,
                        :password_confirmation => @new_password})
                    @user.reload
                  end

                  should "not update the user's password" do
                    assert_not_equal @encrypted_new_password, @user.crypted_password
                  end

                  should_return_from_session :user_id, "@user.id"

                  should_render_template "edit_password"
                end

                context 'with password but blank password confirmation' do
                  setup do
                    put(:change_password,
                        :id => @user.id,
                        :user => {:old_password => 'password',
                        :password => @new_password,
                        :password_confirmation => ''})
                    @user.reload
                  end

                  should "not update the user's password" do
                    assert_not_equal @encrypted_new_password, @user.crypted_password
                  end

                  should_return_from_session :user_id, "@user.id"

                  should_render_template "edit_password"
                end
              end
            end
            
          end
        end
      end
    end
  end
end
