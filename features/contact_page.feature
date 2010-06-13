Feature: Contact page
 In order to provide contact information
 As a visitor
 I should be to see the contact page

@javascript
Scenario: Visiting the contact page
  Given I am on "/#/Contact"
  Then I should see "Contact"
  And I should see "Mark Nijhof"
  And I should see "Phone: 0047 95 00 99 37"
  And I should see "Skype: marknijhof or Mark@Nijhof.com"
  And I should see "E-mail: Mark.Nijhof@Cre8iveThought.com"
  And I should see "Twitter: @MarkNijhof"
  And I should see "GTalk: Mark.Nijhof@Gmail.com"
  And I should see "MSN: Mark@Nijhof.com"
  And I should see "Address: Welhavensgate 49b, 5006 Bergen Norway"

