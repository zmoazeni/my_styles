Feature: Generating Controller Templates
  In order to generate standard CRUD controllers
  A Developer
  Should be able to generate a CRUD controller and the resulting specs
  
  Scenario: Generating Rails CRUD
    Given I'm using a Rails 2.2 code base
    When I generate 'my_controller customer'
    
    # Then 'app/controllers/customers_controller.rb' should be created
    # And 'spec/controllers/customers_controller_spec.rb' should be created
    
    Then the following files should be created:
      | file |
      | app/controllers/customers_controller.rb |
      | spec/controllers/customers_controller_spec.rb |
      | app/helpers/customers_helper.rb |
      | spec/helpers/customers_helper_spec.rb |
    And all the tests should pass
    
  Scenario: Generating Rails CRUD with Views
    Given I'm using a Rails 2.2 code base
    When I generate 'my_controller customer --include-views'
    Then the following files should be created:
      | file |
      | app/controllers/customers_controller.rb |
      | spec/controllers/customers_controller_spec.rb |
      | app/helpers/customers_helper.rb |
      | spec/helpers/customers_helper_spec.rb |
      | app/views/customers/index.html.erb |
      | spec/views/customers/index.html.erb_spec.rb |
      | app/views/customers/edit.html.erb |
      | spec/views/customers/edit.html.erb_spec.rb |
      | app/views/customers/new.html.erb |
      | spec/views/customers/new.html.erb_spec.rb |
#      | app/views/customers/_form.html.erb |
#      | spec/views/customers/_form.html.erb_spec.rb |
#      | app/views/customers/show.html.erb |
#      | spec/views/customers/show.html.erb_spec.rb |
    And all the tests should pass