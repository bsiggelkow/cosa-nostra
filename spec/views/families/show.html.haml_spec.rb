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
  
  it "should have an h3 with the family name" do
    do_render
    response.should have_tag("h3", @family.name)
  end
  
  it "should have status" do
    do_render
    response.should have_tag("tr") {
      with_tag("td", @family.users.first.state)
    }
  end
  describe "when user logged in is viewing information about the other family" do
    describe "and when a family member of the other family is alive" do
      describe "and a hit has not been issued" do
        it "should have an 'Issue Hit' link when logged in user is boss"
        it "should not have an 'Issue Hit' link when logged in as a mobster"
        it "should have actions blank when logged in as a mobster"
      end
    
      describe "and a hit has been issued" do
        it "should have an 'Accept Hit' link when logged in user is mobster"
        it "should not have an 'Accept Hit' link when logged in user is a boss"
        it "should have actions as 'unassigned' when logged in as boss"
      end
    
      describe "and a hit has been accepted" do
        it "should have 'Fail' link when logged in user is mobster"
        it "should have 'Complete' link when logged in user is mobster"
        it "should have actions as 'assigned' for all users"
      end
    
      describe "and a hit has failed" do
        it "should have an 'Accept Hit' link when logged in as mobster"
        it "should not have an 'Accept Hit' link when logged in as a boss"
        it "should have actions as 'failed'"
      end
    end
    
    describe "and when a family member of the other family is deceased" do
      it "should have deceased for the status for all users"
      it "should have actions set to 'completed' for all users"
      it "should have who they were killed by for all users"
    end
  end

  def do_render
    render :template =>"/families/show"
  end
end