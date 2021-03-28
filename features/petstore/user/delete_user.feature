@user @all
Feature: Delete User

  As a PetStore user
  I can successfully delete an account

  Scenario: Successfully delete a user
    Given microservice is up and running
    When user is created via API
    And request is sent to delete user
    Then the response contains code 200
    And response body is empty