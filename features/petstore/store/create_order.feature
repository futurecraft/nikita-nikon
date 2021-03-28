@order @all
Feature: Create Order

  As a PetStore user
  I can successfully create an order
  Using valid order model & data

  Scenario: Successfully create an order
    Given microservice is up and running
    When order model is created
    And request is sent to create order
    Then the response contains code 200
    And response body fields match model