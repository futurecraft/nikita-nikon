@pet @all
Feature: Delete Pet

  As a PetStore user
  I can successfully delete a pet record

  Scenario: Successfully delete a pet
    Given microservice is up and running
    When pet is created via API
    And request is sent to delete pet
    Then the response contains code 200
    And response body includes valid confirmation message:
      """
      Pet deleted
      """