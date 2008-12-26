require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../../spec_helper')

describe "/<%= table_name %>/show.html.erb" do
  before do
    assigns[:<%= file_name %>] = @<%= file_name %> = stub(:to_param => "22")
    
    simple_stub(@<%= file_name %>, <% model_columns.each_with_index do |column, index| %>:<%= column %><%= ", " if index != model_columns.size - 1 %><% end %> )
  end
  
  def do_render
    render "/<%= table_name %>/show.html.erb"
  end
  
  it "should display edit link" do
    do_render
    response.should have_tag("a[href=#{edit_<%= file_name %>_path(22)}]")
  end
  
  it "should display delete link" do
    do_render
    response.should have_tag("a[href=#{<%= file_name %>_path(22)}][onclick=?]", delete_js)
  end
  
  # Fields
  <% model_columns.each do |column| %>    
  it "should display <%= column %>" do
    do_render
    response.should have_text(/the <%= column %>/i)
  end
  <% end %>
  
end

