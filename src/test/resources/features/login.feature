Feature: Tiger - Workshop - Login
  Background:
    Given TGR clear recorded messages

  Scenario: Login and check response attributes
    When I try to log in as "${demo.user.name}" with password "${demo.user.password}"
    And TGR find last request to path "/service/.*"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "400"
    Then TGR current response with attribute "$.body.status" matches "400"
    Then TGR current response with attribute "$.sender.domain" matches "demo"

  Scenario: Login as unregistered user, then register and finally login again
    Given TGR send PUT request to "http://demo/service/deleteUser" with:
      | username  |
      | ${demo.user.name}   |
    And TGR find first request to path "/service/deleteUser"
    Then TGR current response with attribute "$.responseCode" matches "200"
    When I try to log in as "${demo.user.name}" with password "${demo.user.password}"
    And TGR find first request to path "/service/performLogin"
    And TGR current response at "$.body" matches as JSON:
    """
    {
      "timestamp": "${json-unit.ignore}",
      "status": 400,
      "error": "Bad Request",
      "path": "/service/performLogin"
    }
    """

    Then I register as user "${demo.user.name}" with password "${demo.user.password}"
    And TGR find last request to path "/service/performRegistration"
    Then TGR current response with attribute "$.responseCode" matches "200"
    And TGR print current response as rbel-tree
    And TGR current response with attribute "$.body.name" matches "${demo.user.name}"

    Then I try to log in as "${demo.user.name}" with password "${demo.user.password}"
    And TGR find last request to path "/service/performLogin"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "200"
    And TGR current response with attribute "$.body.body.name" matches "${demo.user.name}"
    And TGR current response with attribute "$.body.header.alg" matches "RS256"
    And TGR current response with attribute "$..name" matches "${demo.user.name}"