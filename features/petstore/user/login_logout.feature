@user @all
Feature: Login and Logout

  As a PetStore user
  I can successfully login / logout from my account

  Scenario: Successfully login using users credentials
    Given microservice is up and running
    When user is created via API
    And request is sent to login user
    Then the response contains code 200
    And response body includes session_id

  Scenario: Successfully logout current user session
    Given microservice is up and running
    When user is created via API
    And request is sent to logout user
    Then the response contains code 200
    And response body includes valid confirmation message:
      """
      User logged out
      """
