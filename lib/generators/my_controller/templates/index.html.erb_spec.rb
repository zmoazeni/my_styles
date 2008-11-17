require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../../spec_helper')

describe "/<%= table_name %>/index.html.erb" do
  before do
    @<%= file_name %>1 = stub(:to_param => "67", :id => 67)
    @<%= file_name %>2 = stub(:to_param => "68", :id => 68)
    
    assigns[:<%= plural_name %>] = @<%= plural_name %> = [@<%= file_name %>1, @<%= file_name %>2]
  end
  
  def do_render
    render "/<%= table_name %>/index.html.erb"
  end
  
  it "should not render the list of there are no <%= plural_name %>" do
    assigns[:<%= plural_name %>] = []
    do_render
    response.should_not have_tag("ul")
  end
  
  it "should render the link to view the <%= file_name %>" do
    do_render
    response.should have_tag("a[href=#{<%= file_name %>_path(67)}]", /67/i)
    response.should have_tag("a[href=#{<%= file_name %>_path(68)}]", /68/i)
  end
  
  it "should render the link to edit the <%= file_name %>" do
    do_render
    response.should have_tag("a[href=#{edit_<%= file_name %>_path(67)}]")
    response.should have_tag("a[href=#{edit_<%= file_name %>_path(68)}]")
  end
  
  it "should render the link to delete the <%= file_name %>" do
    do_render
    response.should have_tag("a[href=#{<%= file_name %>_path(67)}][onclick=?]", delete_js)
    response.should have_tag("a[href=#{<%= file_name %>_path(68)}][onclick=?]", delete_js)
  end
end

