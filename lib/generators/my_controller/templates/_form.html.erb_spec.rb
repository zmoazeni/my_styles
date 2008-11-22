require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../../spec_helper')

describe "/<%= table_name %>/_form.html.erb" do
  before do
    @<%= file_name %> = stub
    
    simple_stub(@<%= file_name %>, <% model_columns.each_with_index do |column, index| %>:<%= column %><%= "," if index != model_columns.size - 1 %><% end %> )
      
    template.stubs(:error_messages_for).with(:<%= file_name %>).returns("the errors")
  end
  
  def do_render
    render :partial => "/<%= table_name %>/form.html.erb", :locals => { :f => form_builder(:<%= file_name %>) }
  end
  
  it "should display errors" do
    do_render
    response.should have_text(/the errors/i)
  end
  
  # Fields
  <% full_model_columns.each do |column| %>    
  it "should display <%= column.name %>" do
    do_render
    response.should have_tag(<%= spec_matcher_for_column(column) %>)
  end
  <% end %>
  
end

