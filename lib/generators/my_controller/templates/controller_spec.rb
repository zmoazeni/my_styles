require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '<%= '/..' * class_nesting_depth %>/../spec_helpers/controller_behaviors')

describe <%= controller_class_name %>Controller do
  stub_all_filters!
  
  describe "#index" do
    before do
      <%= class_name %>.stubs(:find).returns("the <%= table_name %>")
    end
    
    def do_get
      get :index
    end
    
    it "should return successfully" do
      do_get
      response.should be_success
    end
    
    it "should render the right template" do
      do_get
      response.should render_template("index")
    end
    
    it "should assign the customers for the view" do
      do_get
      assigns[:<%= table_name %>].should == "the <%= table_name %>"
    end
    
    it "should find the <%= table_name %> correctly" do
      <%= class_name %>.expects(:find).with(:all).returns("the <%= table_name %>")
      do_get
    end
  end
end
