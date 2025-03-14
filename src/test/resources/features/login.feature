Feature: Tiger - Workshop
  Background:
    Given TGR clear recorded messages

  Scenario: Login should fail
    Given TGR send empty POST request to "http://localhost:8090/checkPassword"
    And TGR find last request to path "/checkPassword"
    Then TGR current response with attribute "$.responseCode" matches "400"
    Then TGR current response with attribute "$.body" matches "login incorrect"

  Scenario: Login should succeed
    Given TGR send POST request to "http://localhost:8090/checkPassword" with body "secret"
    And TGR find last request to path "/checkPassword"
    Then TGR current response with attribute "$.responseCode" matches "200"
    Then TGR current response with attribute "$.body" matches "login correct"