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
    Given TGR send empty DELETE request to "http://demo/service/users/${demo.user.${username}.password}"
    And TGR find first request to path "/service/users/.*"
    Then TGR current response with attribute "$.responseCode" matches "204"
    When I try to log in as "${demo.user.${username}.name}" with password "${demo.user.${username}.password}"
    And TGR find first request to path "/service/login"
    Then TGR current response with attribute "$.body.status" matches "400"
    And TGR current response with attribute "$.body.error" matches "Bad Request"

    Then I register as user "${demo.user.${username}.name}" with password "${demo.user.${username}.password}"
    And TGR find last request to path "/service/register"
    Then TGR current response with attribute "$.responseCode" matches "201"
    And TGR print current response as rbel-tree
    And TGR current response with attribute "$.body.name" matches "${demo.user.${username}.name}"

    Then I try to log in as "${demo.user.${username}.name}" with password "${demo.user.${username}.password}"
    And TGR find last request to path "/service/login"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "200"