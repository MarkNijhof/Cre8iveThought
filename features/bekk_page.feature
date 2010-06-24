Feature: BEKK page
 In order to explain about my move to BEKK
 As a visitor
 I should be to see the BEKK page

@javascript
Scenario: Visiting the BEKK page
  Given I am on "/#/BEKK"
  Then I should see "BEKK"
  And I should see "Oslo"

