require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/families/1/show.html.haml" do
  before(:each) do
    @family = Factory(:family)
    assigns[:families] = [@family]
  end
  
  it "should render" do
    do_render
  end

  def do_render
    render_template "/families/#{@family.id}"
  end
end