@pet @all
Feature: Update Pet

  As a PetStore user
  I can successfully update pet record
  Using valid pet model & data

  Scenario: Successfully update a pet
    Given microservice is up and running
    When pet is created via API
    And pet model is created
    When request is sent to update pet
    Then the response contains code 200
    And response body fields match model