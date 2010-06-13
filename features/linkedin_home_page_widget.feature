
Feature: Users should be able to import their LinkedIn profile from the homepage
 In order to provide value to our users
 As a registered user
 I should be able to be import my LinkedIn profile from the homepage

@javascript
Scenario: Visiting the home page when logged-in it will show the LinkedIn widget when the user has no LinkedIn provider or profile
  Given I am signed in and my first name is "Mark" and last name is "Nijhof" and I can "see_it_all"
  And I am on "/"
  Then I should see "LinkedIn"
  And I should see "If you have a LinkedIn account then we can automatically import your profile from there into 17Jobs.com."

@javascript
Scenario: Visiting the home page when logged-in it will show the LinkedIn widget when the user has a LinkedIn provider but no profile
  Given I am signed in and my first name is "Mark" and last name is "Nijhof" and I can "see_it_all"
  And I have signed in before using my LinkedIn account
  And I am on "/"
  Then I should see "LinkedIn"
  And I should see "We have noticed that you have a LinkedIn account, you can import your LinkedIn profile into 17Jobs.com to make creating your CV's a lot simpler. Just use the button below to start this process."

@javascript
Scenario: Visiting the home page when logged-in it will show the LinkedIn widget when the user has a LinkedIn provider but no profile
  Given I am signed in and my first name is "Mark" and last name is "Nijhof" and I can "see_it_all"
  And I have signed in before using my LinkedIn account
  And I am on "/"
  When I click on "ImportLinkedInProfileButton"
  Then the "ImportLinkedInProfileButton" will be disabled

@javascript
Scenario: 
  Given I am signed in and my first name is "Mark" and last name is "Nijhof" and I can "see_it_all"
  And I have signed in before using my LinkedIn account
  And I have imported my LinkedIn profile before with the following attributes:
    | first_name | last_name | headline  | industry | num_recommenders | summary | specialties | honors | interests | picture_url |
    | Mark       | Nijhof    | Head line | IT       | 2                | Summary | Specialties | Honors | Interests | Picture Url |
  And My imported LinkedIn profile has the following positions:
    | title   | summary | start_year | start_month | end_year | end_month | is_current | company_type | name      | industry |
    | Title 2 | Summary | 2010       | 2           |          |           |            |              | Company B |          |  
    | Title 1 | Summary | 2009       | 4           | 2010     | 2         |            |              | Company A |          |
  And I am on "/"
  Then I should see "LinkedIn"
  And I should see "We have an imported copy of your LinkedIn profile in our system with the headline: Head line"
  And I should see "The position Title 2 at Company B which you held since February 2010 is the last out of 2 imported positions."
  And I should see "Your Profile"
