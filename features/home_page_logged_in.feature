
Feature: Users should be able to be signed-in
 In order to provide value to our users
 As a registered user
 I should be able to be signed-in

@javascript
Scenario: Visiting the home page when logged-in it will show my name
  Given I am signed in and my first name is "Mark" and last name is "Nijhof"
  And I am on "/"
  Then I should see a link "Mark Nijhof"
  And I should not see "LinkedIn"
  And I should not see "Facebook"
  