Feature: Example

  Background:
    Given TGR clear recorded messages
    Given TGR set global variable "connectionFlag" to "application/soap+xml; charset=utf-8"
    Given TGR set global variable "responseBody" to "!{file('data/response.xml')}"
    Given TGR set global variable "responseStatusCode" to "200"
    Given TGR set global variable "viaFlag" to "1.1 john"

  Scenario: Todo


