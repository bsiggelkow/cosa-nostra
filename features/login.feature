Feature: login
  In order to issue hits
  As a boss
  I want to login and view the family list

Scenario: login as a boss
  # Given the following user records
  #   | email          | password |
  #   | boss@mafia.com | password |
  Given I am on the homepage
  When I fill in "session_email" with "gorgeous@bonanno.com"
   And I fill in "session_password" with "password"
   And I press "Login"
  Then I should be on the list of families




  
