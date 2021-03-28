@pet @all
Feature: Create Pet

  As a PetStore user
  I can successfully add a pet record
  Using valid pet model & data

  Scenario: Successfully create a pet
    Given microservice is up and running
    When pet model is created
    And request is sent to create pet
    Then the response contains code 200
    And response body fields match model