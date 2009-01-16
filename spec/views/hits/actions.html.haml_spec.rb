require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "hits/_actions.html.haml" do
  before do    
    @desi = Factory :user, :first_name => "Desi"
  end
  
  it "should render" do
    template.expects(:can_accept_hit?).at_least(1).returns(false)
    template.expects(:can_complete_hit?).at_least(1).returns(false)
    template.expects(:can_fail_hit?).at_least(1).returns(false)
    template.expects(:can_issue_hit?).returns(true)
    do_render
  end
  
  describe "when user logged in is viewing information about the other family" do
    describe "and when a family member of the other family is alive" do
      describe "and a hit has not been issued" do
        before(:each) do
          template.expects(:can_accept_hit?).returns(false)
          template.expects(:can_complete_hit?).returns(false)
          template.expects(:can_fail_hit?).returns(false)
        end
        
        it "should have an 'Issue Hit' link when permission to issue hit is true" do
          template.expects(:can_issue_hit?).at_least(1).returns(true)
          do_render
          response.should have_tag('a[href=?]', new_hit_path(:target_id => @desi.id))

          # if this was a button it would look like this instead
          # response.should have_tag('a[href$=?]', new_hit_path(:target_id => @desi.id))
        end

        it "should not have an 'Issue Hit' link when permission to issue hit is false" do
          template.expects(:can_issue_hit?).at_least(1).returns(false)
          do_render
          response.should_not have_tag('a[href=?]', new_hit_path(:target_id => @desi.id))
        end
      end
    
      describe "and a hit is ready to be accepted" do
        before do 
          template.expects(:can_issue_hit?).returns(false)
          template.expects(:can_complete_hit?).returns(false)
          template.expects(:can_fail_hit?).returns(false)
        end
        
        it "should have an 'Accept Hit' link when can accept hit is true" do
          template.expects(:can_accept_hit?).returns(true) 
          user = Factory :user
          
          hit = Factory :hit, :target => @desi, :assigned_to => user
          @desi.expects(:target_hit).returns(hit)
          do_render
          response.should have_tag('a[href=?]', accept_hit_path(hit))
        end
        
        it "should not have an 'Accept Hit' link when can accept hit is false"
      end
    
      describe "and a hit is ready to be completed" do
        # These are left for you to complete if you want
        it "should have 'Complete' link when can complete is true"
        it "should not have 'Complete' link when can complete is false"
      end
      
      describe "and a hit is ready to be failed" do
        # These are left for you to complete if you want
        it "should have 'Fail' link when can fail is true"
        it "should not have 'Fail' link when can fail is true"
      end
    end
  end
  
  def do_render
    render :partial =>"hits/actions.html.haml", :locals => {:target => @desi}
  end
end