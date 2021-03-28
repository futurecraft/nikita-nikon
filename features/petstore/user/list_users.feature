@user @all
Feature: Get User

  As a PetStore user
  I can successfully retrieve a user

  Scenario: Successfully get a user
    Given microservice is up and running
    When user is created via API
    And request is sent to retrieve user
    Then the response contains code 200
    And response body fields match API created user fields

  Scenario: Trying to retrieve an unexisting user results in error
    Given microservice is up and running
    When user model is created
    And request is sent to retrieve this unexisting user
    Then the response contains code 404
    And response body includes valid error message:
      """
      User not found
      """