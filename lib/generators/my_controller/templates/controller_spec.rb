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
    
    it "should assign the <%= table_name %> for the view" do
      do_get
      assigns[:<%= table_name %>].should == "the <%= table_name %>"
    end
    
    it "should find the <%= table_name %> correctly" do
      <%= class_name %>.expects(:find).with(:all).returns("the <%= table_name %>")
      do_get
    end
  end
  
  describe "#new" do
    before do
      <%= class_name %>.stubs(:new).returns("the <%= file_name %>")
    end
    
    def do_get
      get :new
    end
    
    it "should return successfully" do
      do_get
      response.should be_success
    end
    
    it "should render the right template" do
      do_get
      response.should render_template("new")
    end
    
    it "should assign a <%= class_name %> for the view" do
      do_get
      assigns[:<%= file_name %>].should == "the <%= file_name %>"
    end
    
    it "should instantiate the <%= class_name %> correctly" do
      <%= class_name %>.expects(:new).with().returns("the <%= file_name %>")
      do_get
    end
  end
  
  describe "#create" do
    before do
      <%= class_name %>.stubs(:new).returns(@<%= file_name %> = stub)
    end
    
    def do_post_success
      @<%= file_name %>.stubs(:save).returns(true)
      post :create, :<%= file_name %> => { :foo => "bar" }
    end
    
    def do_post_fail      
      @<%= file_name %>.stubs(:save).returns(false)
      post :create, :<%= file_name %> => { :foo => "bar" }
    end
    
    it "should redirect to show on success" do
      do_post_success
      response.should redirect_to(<%= file_name %>_path(@<%= file_name %>))
    end
    
    it "should return successfully on failure" do
      do_post_fail
      response.should be_success
    end
    
    it "should render the correct template on failure" do
      do_post_fail
      response.should render_template("new")
    end
    
    it "should assign a <%= class_name %> for the view" do
      do_post_success
      assigns[:<%= file_name %>].should == @<%= file_name %>
    end
    
    it "should assign a flash message on success" do
      do_post_success
      flash[:notice].should match(/the <%= file_name %> was created/i)
    end
    
    it "should instantiate the <%= class_name %> correctly" do
      <%= class_name %>.expects(:new).with("foo" => "bar").returns(@<%= file_name %>)
      do_post_success
    end
  end
  
  describe "#edit" do
    before do
      <%= class_name %>.stubs(:find).returns("the <%= file_name %>")
    end
    
    def do_get
      get :edit, :id => "31"
    end
    
    it "should return successfully" do
      do_get
      response.should be_success
    end
    
    it "should render the right template" do
      do_get
      response.should render_template("edit")
    end
    
    it "should assign the <%= file_name %> for the view" do
      do_get
      assigns[:<%= file_name %>].should == "the <%= file_name %>"
    end
    
    it "should find the <%= file_name %> correctly" do
      <%= class_name %>.expects(:find).with("31").returns("the <%= file_name %>")
      do_get
    end
  end
  
  describe "#update" do
    before do
      <%= class_name %>.stubs(:find).returns(@<%= file_name %> = stub)
    end
    
    def do_put_success
      @<%= file_name %>.stubs(:update_attributes).returns(true)
      put :update, :<%= file_name %> => { :foo => "bar" }, :id => "92"
    end
    
    def do_put_fail
      @<%= file_name %>.stubs(:update_attributes).returns(false)
      put :update, :<%= file_name %> => { :foo => "bar" }, :id => "92"
    end
    
    it "should redirect to show on success" do
      do_put_success
      response.should redirect_to(<%= file_name %>_path(@<%= file_name %>))
    end
    
    it "should return successfully on failure" do
      do_put_fail
      response.should be_success
    end
    
    it "should render the correct template on failure" do
      do_put_fail
      response.should render_template("edit")
    end
    
    it "should assign a <%= class_name %> for the view" do
      do_put_success
      assigns[:<%= file_name %>].should == @<%= file_name %>
    end
    
    it "should assign a flash message on success" do
      do_put_success
      flash[:notice].should match(/the <%= file_name %> was updated/i)
    end
    
    it "should find the <%= file_name %> correctly" do
      <%= class_name %>.expects(:find).with("92").returns(@<%= file_name %>)
      do_put_success
    end
    
    it "should save the <%= file_name %> correctly" do
      @<%= file_name %>.expects(:update_attributes).with("foo" => "bar").returns(true)
      put :update, :<%= file_name %> => { :foo => "bar" }, :id => "92"
    end
  end
  
  describe "#show" do
    before do
      <%= class_name %>.stubs(:find).returns(@<%= file_name %> = stub)
    end
    
    def do_get
      get :show, :id => "93"
    end
    
    it "should return successfully" do
      do_get
      response.should be_success
    end
    
    it "should render the correct template" do
      do_get
      response.should render_template("show")
    end
    
    it "should assign the <%= file_name %> for the view" do
      do_get
      assigns[:<%= file_name %>].should == @<%= file_name %>
    end
    
    it "should find the <%= file_name %> correctly" do
      <%= class_name %>.expects(:find).with("93").returns(@<%= file_name %>)
      do_get
    end
  end
  
  describe "#destroy" do
    before do
      <%= class_name %>.stubs(:destroy)
    end
    
    def do_delete
      delete :destroy, :id => "94"
    end
    
    it "should redirect to index" do
      do_delete
      response.should redirect_to(<%= table_name %>_path)
    end
    
    it "should update flash" do
      do_delete
      flash[:notice].should match(/the <%= file_name %> was deleted/i)
    end
    
    it "should destroy the <%= file_name %>" do
      <%= class_name %>.expects(:destroy).with("94")
      do_delete
    end
  end
end
