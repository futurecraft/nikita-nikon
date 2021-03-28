@order @all
Feature: Delete Order

  As a PetStore user
  I can successfully delete an order

  Scenario: Successfully create an order
    Given microservice is up and running
    When order is created via API
    And request is sent to delete order
    Then the response contains code 200
    And response body is empty