@order @all
Feature: List Orders

  As a PetStore user
  I can successfully retrieve an order

  Scenario: Successfully retrieve an order
    Given microservice is up and running
    When order is created via API
    And request is sent to retrieve order
    Then the response contains code 200
    And response body fields match API created order fields