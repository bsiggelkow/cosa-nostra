require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/families/1/show.html.haml" do
  before(:each) do
    @family = Factory(:family)
    @user = Factory :user, :family => @family
    template.stubs(:current_user).returns(@user)
    assigns[:family] = @family
  end
  
  it "should render" do
    do_render
  end
  
  it "should have text of the family name" do
    do_render
    response.should have_text(@family.name)
  end
  
  it "should have an h3 with the family name" do
    do_render
    response.should have_tag("<h3>")
  end

  def do_render
    render :template =>"/families/show"
  end
end