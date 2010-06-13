Feature: Home page
 In order to have a useful website
 As a visitor
 I should be to see the home page

@javascript
Scenario: Visiting the home page
  Given I am on "/#/"
  Then I should see an image "http://cre8ivethought.s3.amazonaws.com/images/Cre8iveBusinessCardsPresentation.png"

