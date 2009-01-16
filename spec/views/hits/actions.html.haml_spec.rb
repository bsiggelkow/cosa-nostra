require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "hits/_actions.html.haml" do
  before do    
    @desi = Factory :user, :first_name => "Desi"
  end
  
  it "should render" do
    template.expects(:can_issue_hit).returns(true)
    do_render
  end
  
  describe "when user logged in is viewing information about the other family" do
    describe "and when a family member of the other family is alive" do
      describe "and a hit has not been issued" do
        it "should have an 'Issue Hit' link when logged in user is boss" do
          template.expects(:can_issue_hit).at_least(1).returns(true)
          stubs(:current_user).returns(Factory :user)
          do_render
          response.should have_tag('a[href=?]', new_hit_path(:target_id => @desi.id))

          # if this was a button it would look like this instead
          # response.should have_tag('a[href$=?]', new_hit_path(:target_id => @desi.id))
        end

        it "should not have an 'Issue Hit' link when logged in as a mobster" do
          template.expects(:can_issue_hit).at_least(1).returns(false)
          stubs(:current_user).returns(@mobster)
          do_render
          response.should_not have_tag('a[href=?]', new_hit_path(:target_id => @desi.id))
        end

        it "should have actions blank when logged in as a mobster" do
          
        end
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
    render :partial =>"hits/actions.html.haml", :locals => {:target => @desi}
  end
end