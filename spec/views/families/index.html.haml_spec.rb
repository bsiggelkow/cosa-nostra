require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/families/index.html.haml" do
  before(:each) do
    @jordan = Factory(:family, :name => "Jordan")
    @mcadam = Factory(:family, :name => "McAdam")
    families = [@jordan, @mcadam]
    
    families.each do |family|
      # create 3 dead ones 
      3.times do 
        @user = Factory(:user, :family => family)
        @user.kill!
      end
      # create 2 living
      2.times do 
        @user = Factory(:user, :family => family)
      end
    end

    assigns[:families] = families
  end
  
  it "should render" do
    do_render
  end
  
  it "should have a heading"
  
  it "should have the families names" do
    do_render
    response.should have_tag('tr') {
      with_tag('td', "Jordan")
      with_tag('td', "McAdam")
    }
  end
  
  it "should have a link to the family name" do
    do_render
    response.should have_tag('a[href=?]', family_path(@jordan))
  end
  
  it "should have a count of the alive members for one family"
  it "should have a count of the deceased members for one family"

  def do_render
    render '/families/index.html.haml'
  end
end
