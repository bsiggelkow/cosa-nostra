require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe "/families/1/show.html.haml" do
  include UsersHelper
  
  before(:each) do
    @family = Factory(:family)
    @user = Factory :user, :family => @family
    template.stubs(:current_user).returns(@user)
    assigns[:family] = @family
  end
  
  it "should render" do
    do_render
  end
  
  it "should have an h3 with the family name"  do
    do_render
    response.should have_tag("h3",:count => 1)
    response.should have_tag("h3",:text => @family.name, :count => 1)
  end
  
  it "should have status" do
    do_render
    response.should have_tag("table") do
      with_tag("tr:nth-child(2)") do
        with_tag("td:nth-last-child(2)", status(@family.users.first))
      end
    end
  end

  def do_render
    render :template =>"/families/show"
  end
end