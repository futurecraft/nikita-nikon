@user @all
Feature: Create User

  As a PetStore user
  I can successfully create an account
  Using valid user model & data

  Scenario: Successfully create a user
    Given microservice is up and running
    When user model is created
    And request is sent to create user
    Then the response contains code 200
    And response body fields match model