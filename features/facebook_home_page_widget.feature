
Feature: Users should be able to import their Facebook profile from the homepage
 In order to provide value to our users
 As a registered user
 I should be able to be import my Facebook profile from the homepage

@javascript
Scenario: Visiting the home page when logged-in it will show the Facebook widget
  Given I am signed in and my first name is "Mark" and last name is "Nijhof" and I can "see_it_all"
  And I am on "/"
  Then I should see "Facebook"
  And I should see "If you have a Facebook account then we can automatically import your profile from there into 17Jobs.com."

