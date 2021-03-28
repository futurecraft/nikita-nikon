@user @all
Feature: Update User

  As a PetStore user
  I can successfully update user account
  Using valid user model & data

  Scenario: Successfully update a user
    Given microservice is up and running
    When user is created via API
    And user model is created
    When request is sent to update user
    Then the response contains code 200
    And response body fields match model