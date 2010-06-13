Feature: Keep me up to date with your progress
  In order to have potential users stay interested
  As a guest or not logged-in user
  I should be able to leave my name and e-mail address to get updates

@javascript
Scenario: Visiting the home page when not logged-in
  Given I am on "/"
  Then I should see "Welcome at 17Jobs.com"
  And I should not see "Thank you for your interest, we will take good care of you and keep you informed about 17Jobs.com progress."
  And I should not see "Your e-mail address appears to be already registered, if you feel this is by mistake or you want to be removed from our database then please e-mail us at"
    
@javascript
Scenario: Inserting my name and e-mail address for the first time
  Given I am on "/"
  When I fill in "keep_updated_name" with "Mark Nijhof"
  And I fill in "keep_updated_email" with "Mark.Nijhof@Gmail.com"
  And I click on "keep_updated_submit"
  Then the "keep_updated_submit" will be disabled
  And I should see "Thank you for your interest, we will take good care of you and keep you informed about 17Jobs.com progress."
  And I should not see "My name is:"
  And I should not see "And my e-mail address is:"
  
@javascript
Scenario: Inserting my name and e-mail address for the second time
  Given I am on "/"
  When I fill in "keep_updated_name" with "Mark Nijhof"
  And I fill in "keep_updated_email" with "Mark.Nijhof@Gmail.com"
  And I click on "keep_updated_submit"
  And I go to "/"
  And I fill in "keep_updated_name" with "Mark Nijhof"
  And I fill in "keep_updated_email" with "Mark.Nijhof@Gmail.com"
  And I click on "keep_updated_submit"
  Then the "keep_updated_submit" will be disabled
  And I should see "Your e-mail address appears to be already registered, if you feel this is by mistake or you want to be removed from our database then please e-mail us at"
  And I should not see "My name is:"
  And I should not see "And my e-mail address is:"
