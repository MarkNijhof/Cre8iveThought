
Feature: Users should be able to view their profile
 In order to provide value to our users
 As a registered user
 I should be able to view his profile on 17Jobs.com

# Background: Logged on user with profile 
#   Given I am signed in and my first name is "Mark" and last name is "Nijhof" and I can "see_it_all"
#   And I have signed in before using my LinkedIn account
#   And I have imported my LinkedIn profile before with the following attributes:
#     | first_name | last_name | headline  | industry | num_recommenders | summary | specialties | honors | interests | picture_url |
#     | Mark       | Nijhof    | Head line | IT       | 2                | Summary | Specialties | Honors | Interests | Picture Url |
#   And My imported LinkedIn profile has the following positions:
#     | title   | summary | start_year | start_month | end_year | end_month | is_current | company_type | name      | industry |
#     | Title 2 | Summary | 2010       | 2           |          |           |            |              | Company B |          |  
#     | Title 1 | Summary | 2009       | 4           | 2010     | 2         |            |              | Company A |          |

@javascript
Scenario: Visiting the profile page after being logged-in
  Given I am signed in and my first name is "Mark" and last name is "Nijhof" and I can "see_it_all"
  And I am on "/my_profile"
  Then I should see "Hi Mark Nijhof, this is your profile"
