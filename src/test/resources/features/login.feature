Feature: Tiger - Workshop - Login
  Background:
    Given TGR clear recorded messages

  Scenario: Login and check response attributes
    When I try to log in as "user1" with password "password123"
#    When TGR send POST request to "http://demo/service/login" with:
#    | username | password |
#    | user1    | 123      |
#    When TGR send empty POST request to "http://demo/service/login?username=user1&password=123"
    And TGR find last request to path "/service/.*"
    Then TGR current response with attribute "$.responseCode" matches "400"
