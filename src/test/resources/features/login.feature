Feature: Tiger - Workshop - Login
  Background:
    Given TGR clear recorded messages

  Scenario: Login and check response attributes
    When I try to log in as "user1" with password "password123"
    And TGR find last request to path "/service/.*"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "400"
    Then TGR current response with attribute "$.body.status" matches "400"
    Then TGR current response with attribute "$.sender.domain" matches "demo"

  Scenario: Login as unregistered user, then register and finally login again
    Given TGR send PUT request to "http://demo/service/deleteUser" with:
      | username  |
      | user123   |
    And TGR find first request to path "/service/deleteUser"
    Then TGR current response with attribute "$.responseCode" matches "200"
    When I try to log in as "user123" with password "password123"
    And TGR find first request to path "/service/performLogin"
    Then TGR current response with attribute "$.body.status" matches "400"
    And TGR current response with attribute "$.body.error" matches "Bad Request"

    Then I register as user "user123" with password "password123"
    And TGR find first request to path "/service/performRegistration"
    Then TGR current response with attribute "$.responseCode" matches "200"
    And TGR print current response as rbel-tree
    And TGR current response with attribute "$.body.name" matches "user123"

    Then I try to log in as "user123" with password "password123"
    And TGR find last request to path "/service/performLogin"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "200"