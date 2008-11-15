Feature: Generating Controller Templates
  In order to write CRUD controllers
  A Developer
  Should be able to generate CRUD controller and the resulting tests
  
  Scenario: Generating Rails CRUD
    Given I'm using a Rails 2.2 code base
    When I generate 'my_controller customer'
    Then all the tests should pass