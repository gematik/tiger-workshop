Feature: Tiger - Workshop - Login
  Background:
    Given TGR clear recorded messages

  Scenario: Login and check response attributes
   # When I try to log in as "user1" with password "password123"
    When TGR send GET request to "http://demo/service/performLogin" with:
    | username | password |
    | user1    | 123      |
    # When TGR send empty GET request to "http://demo/service/performLogin?username=user1&password=123"
    And TGR find last request to path "/service/.*"
    Then TGR current response with attribute "$.responseCode" matches "400"
