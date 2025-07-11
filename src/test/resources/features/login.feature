Feature: Tiger - Workshop - Login
  Background:
    Given TGR clear recorded messages

  Scenario: Login and check response attributes
    Given TGR set global variable "username" to "tim"
    When I try to log in as "${demo.user.${username}.name}" with password "${demo.user.${username}.password}"
    And TGR find last request to path "/service/.*"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "400"
    Then TGR current response with attribute "$.body.status" matches "400"
    Then TGR current response with attribute "$.sender.domain" matches "demo"

  Scenario: Login as unregistered user, then register and finally login again
    Given TGR send PUT request to "http://demo/service/deleteUser" with:
      | username  |
      | ${demo.user.${username}.name}   |
    And TGR find request to path "/service/deleteUser"
    Then TGR current response with attribute "$.responseCode" matches "200"
    When I try to log in as "${demo.user.${username}.name}" with password "${demo.user.${username}.password}"
    And TGR find request to path "/service/performLogin"
    Then TGR current response with attribute "$.body.status" matches "400"
    And TGR current response with attribute "$.body.error" matches "Bad Request"

    Then I register as user "${demo.user.${username}.name}" with password "${demo.user.${username}.password}"
    And TGR find last request to path "/service/performRegistration"
    Then TGR current response with attribute "$.responseCode" matches "200"
    And TGR print current response as rbel-tree
    And TGR current response with attribute "$.body.name" matches "${demo.user.${username}.name}"

    Then I try to log in as "${demo.user.${username}.name}" with password "${demo.user.${username}.password}"
    And TGR find last request to path "/service/performLogin"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "200"