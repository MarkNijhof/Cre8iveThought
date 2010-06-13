Feature: Services page
 In order to explain about our services
 As a visitor
 I should be to see the services page

@javascript
Scenario: Visiting the services page
  Given I am on "/#/Services"
  Then I should see "Development"
  And I should see "Coaching"

