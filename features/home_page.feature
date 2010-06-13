Feature: Sign-in and Sign-up
 In order to get more users
 As a guest or not logged-in user
 I should be able to sign-up and sign-in

@javascript
Scenario: Visiting the home page when not logged-in it will load two graphic panels
  Given I am on "/"
  Then I should see an image "http://17jobs.s3.amazonaws.com/images/hire-me-2.jpg"
  And I should see an image "http://17jobs.s3.amazonaws.com/images/hire-me-3.jpg"

@javascript
Scenario: Visiting the home page when not logged-in
  Given I am on "/"
  Then I should see a link "Sign Up!"
  And I should see a link "Sign In!" 
  And I should see "17Jobs.com © 2010 cre8ive thought" 
  And I should not see "Why sign up?"
  And I should not see "LinkedIn"
  And I should not see "Facebook"
    
@javascript
Scenario: When clicking on the Sign-up link it will display the login panel
  Given I am on "/"
  When I follow "Sign Up!"
  Then I should see "Why sign up?"
  And I should see "Well currently we don't know who you are, and we would like to change that so we can provide you with a better service. We have chosen an approach which makes this very easy; all you have to do is choose your preferred account on the right and sign in with it. This will automatically create a profile for you here on 17Jobs.com."
  And I should see "Then what?"
  And I should see "After you have signed in you will be able to create and maintain your CV, and that is only the start, more cool functionality will be available to you later..."
  And I should see a button "LinkedIn"
  And I should see a button "Facebook"
  And I should see a button "Twitter"
  And I should see a button "Google"
  And I should see a button "Open ID"
  And I should see a button "17Jobs.com"

@javascript
Scenario: When clicking on the close link after having clicked on the Sign-up link it will hide the login panel again
  Given I am on "/"
  When I follow "Sign Up!"
  And I click on "dropDownHeaderCloseButton"
  Then I should not see "Why sign up?"
  And I should not see "Well currently we don't know who you are, and we would like to change that so we can provide you with a better service. We have chosen an approach which makes this very easy; all you have to do is choose your preferred account on the right and sign in with it. This will automatically create a profile for you here on 17Jobs.com."
  And I should not see "Then what?"
  And I should not see "After you have signed in you will be able to create and maintain your CV, and that is only the start, more cool functionality will be available to you later..."
  # And I should not see a button "LinkedIn"
  # And I should not see a button "Facebook"
  # And I should not see a button "Twitter"
  # And I should not see a button "Google"
  # And I should not see a button "Open ID"
  # And I should not see a button "17Jobs.com"

  @javascript
  Scenario: When clicking on the close link after having clicked on the Sign-up link it will hide the login panel again
    Given I am on "/"
    When I follow "Sign Up!"
    And I click on "dropDownHeaderCloseButton"
    And I should not see a button "LinkedIn"
    And I should not see a button "Facebook"
    And I should not see a button "Twitter"
    And I should not see a button "Google"
    And I should not see a button "Open ID"
    And I should not see a button "17Jobs.com"
