@pet @all
Feature: List Pets

  As a PetStore user
  I can successfully retrieve pet records
  Using different filters

  Scenario: Successfully retrieve pet by ID
    Given microservice is up and running
    When pet is created via API
    And request is sent to retrieve pet by id
    Then the response contains code 200
    And response body fields match API created pet fields

  Scenario: Successfully find pets by tag
    Given microservice is up and running
    When pet is created via API
    And request is sent to retrieve pet by tag
    Then the response contains code 200
    And response body fields include items with the expected tag

  Scenario: Successfully find pets by status
    Given microservice is up and running
    When pet is created via API
    And request is sent to retrieve pet by status
    Then the response contains code 200
    And response body fields include items with the expected status

  Scenario: Impossible to retrieve an unexisting pet by id
    Given microservice is up and running
    When pet model is created
    And request is sent to retrieve this unexisting pet
    Then the response contains code 404
    And response body includes valid error message:
      """
      Pet not found
      """
