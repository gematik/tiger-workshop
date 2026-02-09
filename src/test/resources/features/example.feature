Feature: Example for otherZionServer

  Background:
    Given TGR clear recorded messages

  Scenario: Testfall 1
    Given TGR send empty GET request to "http://otherZionServer/users/123"
    And TGR find last request to path "/users/.*"
    Then TGR current response with attribute "$.responseCode" matches "200"

  Scenario: Testfall JWT
    Given TGR set global variable "responseStatusCode" to "200"
    Given TGR set global variable "responseBody" to "!{file('data/jwt.json')}"
    Given TGR send empty GET request to "http://anotherZionServer/abc"
    And TGR find last request to path "/abc"
    Then TGR current response with attribute "$.responseCode" matches "${responseStatusCode}"

  Scenario: Testfall Bearer Token
    Given TGR set global variable "responseStatusCode" to "200"
    Given TGR set global variable "responseBody" to "!{file('data/bearer.json')}"
    Given TGR send empty GET request to "http://anotherZionServer/abc"
    And TGR find last request to path "/abc"
    Then TGR current response with attribute "$.responseCode" matches "${responseStatusCode}"

  Scenario: Testfall JWE
    Given TGR set global variable "responseStatusCode" to "200"
    Given TGR set global variable "responseBody" to "!{file('data/jwe.json')}"
    Given TGR send empty GET request to "http://anotherZionServer/abc"
    And TGR find last request to path "/abc"
    Then TGR current response with attribute "$.responseCode" matches "${responseStatusCode}"

  Scenario: Testfall HeaderExample
    Given TGR set global variable "contentType" to "application/soap+xml;charset=utf-8"
    Given TGR set global variable "connectionFlag" to "close"
    Given TGR set global variable "responseBody" to "!{file('data/response.xml')}"
    Given TGR set global variable "responseStatusCode" to "200"
    Given TGR set global variable "requestBody" to "!{file('data/request.xml')}"
    Given TGR send POST request to "http://anotherZionServer/efg" with body "${requestBody}"
    And TGR find last request to path "/efg"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "${responseStatusCode}"
    Then TGR current response with attribute "$.body" matches "${responseBody}"
    Then TGR current response with attribute "$.header.[~'content-type']" matches "${contentType}"
    Then TGR current response with attribute "$.header.[~'connection']" matches "${connectionFlag}"

  Scenario: Testfall Delayed
    Given TGR set global variable "delayResponse" to "5000"
    Given TGR set global variable "responseBody" to "!{file('data/response.xml')}"
    Given TGR set global variable "responseStatusCode" to "200"
    Given TGR set global variable "requestBody" to "!{file('data/request.xml')}"
    Given TGR send POST request to "http://anotherZionServer/efg" with body "${requestBody}"
    And TGR find last request to path "/efg"
    And TGR print current response as rbel-tree
    Then TGR current response with attribute "$.responseCode" matches "${responseStatusCode}"
    Then TGR current response with attribute "$.body" matches "${responseBody}"
