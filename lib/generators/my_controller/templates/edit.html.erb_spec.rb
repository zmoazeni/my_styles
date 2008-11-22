require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../../spec_helper')

describe "/<%= table_name %>/edit.html.erb" do
  before do
    assigns[:<%= file_name %>] = @<%= file_name %> = stub(:to_param => "31")
    
    template.should_receive(:render).with(:partial => "form", :locals => { :f => form_builder(:customer) }).and_return("the form")
  end
  
  def do_render
    render "/<%= table_name %>/edit.html.erb"
  end
    
  it "should display the form" do
    do_render
    response.should have_tag("form[action=#{<%= file_name %>_path(31)}]")
  end
  
  it "should render the form partial" do
    do_render
    response.should have_text(/the form/i)
  end

  it "should display a submit button" do
    do_render
    response.should have_tag("form input[type=submit]")
  end
  
  it "should display a cancel link" do
    do_render
    response.should have_tag("a[href=#{<%= file_name %>_path(31)}]")
  end
end

