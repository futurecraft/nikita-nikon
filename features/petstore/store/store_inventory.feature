@order @all
Feature: Store inventory

  As a PetStore user
  I can successfully access inventory
  While being logged as a valid user

  Scenario: Successfully access store inventory
    Given microservice is up and running
    # When user is created via API
    And request is sent to get inventory
    Then the response contains code 200
    And response body includes the following fields:
      | approved  |
      | placed    |
      | delivered |

