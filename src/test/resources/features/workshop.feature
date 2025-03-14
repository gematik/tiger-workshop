Feature: Tiger - Workshop

  Background:
    Given TGR clear recorded messages

  Scenario: Call health check
    Given I control the health endpoint
    Then TGR send empty GET request to "http://demo/service/hello"
    And TGR find request to path "/service/.*"
    Then TGR current response with attribute "$.responseCode" matches "200"
    And TGR current response with attribute "$.body" matches "OK"

  Scenario: Call health check 2
    Then TGR send empty GET request to "http://demo/service/hello"
    Given I control the health endpoint
    And TGR find request to path "/service/.*"
    And TGR find next request to path "/service/.*"
    Then TGR current response with attribute "$.responseCode" matches "200"
    And TGR current response with attribute "$.body" matches "OK"
