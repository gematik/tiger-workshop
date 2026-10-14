Feature: Tiger - Workshop - Login für mehrere User
  Background:
    Given TGR clear recorded messages

  Scenario Outline: mehrere User registrieren
    Given TGR set global variable "username" to "tim"
    Given TGR send GET request to "http://demo/service/register" with:
      | username | password   |
      | <name>   | <password> |
    And TGR find last request to path "/service/register"
    Then TGR current response with attribute "$.responseCode" matches "201"
    And TGR print current response as rbel-tree
    And TGR current response with attribute "$.body.name" matches "<name>"
    Examples:
      | name                               | password              |
      | ${demo.user.name}                  | ${demo.user.password} |
      | ${demo.user.keinName\|defaultUser} | xys                   |