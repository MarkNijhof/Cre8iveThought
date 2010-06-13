Feature: Speaking page
 In order to tell you where I am speaking
 As a visitor
 I should be to see the speaking page

@javascript
Scenario: Visiting the speaking page
  Given I am on "/#/Speaking"
  Then I should see "Speaking"
  And I should see "NDC 2010"

