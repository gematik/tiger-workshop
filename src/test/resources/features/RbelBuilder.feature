Feature: Tiger - Workshop - RbelBuilder
  Background:
    Given TGR clear recorded messages
    Given TGR set global variable "responseBody" to "!{file('src/test/resources/data/example.json')}"

  Scenario: Replace certain values in a response
    Given TGR send empty GET request to "http://localhost:8090/rbelbuilder"
    When TGR find request to path "/rbelbuilder"
    Then TGR print all messages as rbel-tree

    # creates a new rbel object primitive value
    Given TGR creates a new Rbel object 'someObjName' with content '{"address": {"street": "123 Main St","city": "Berlin","postalCode": "10115"}}'
    Then TGR sets Rbel object 'someObjName' at '$address.street' to new value 'Hauptstrasse'
    Then TGR asserts '!{rbelObject:serialize("someObjName")}' equals '{"address": {"street": "Hauptstrasse","city": "Berlin","postalCode": "10115"}}' of type JSON

    # replacing object nodes
    Given TGR creates a new Rbel object 'phoneNumbers' with content '{"phoneNumbers": [{"type": "home",  "number": "030-1234567"},{  "type": "mobile", "number": "0176-123456788"  }]}'
    When TGR sets Rbel object 'phoneNumbers' at '$phoneNumbers.1' to new value '{"type" : "work", "number" : "0176-199999"}'
    #When TGR sets Rbel object 'phoneNumbers' at '$phoneNumbers.1.type' to new value 'work'
    #When TGR sets Rbel object 'phoneNumbers' at '$phoneNumbers.1.number' to new value '0176-199999'
    Then TGR asserts '!{rbelObject:serialize("phoneNumbers")}' equals '{"phoneNumbers": [{"type": "home",  "number": "030-1234567"},{  "type": "work", "number": "0176-199999"}]}' of type JSON

    # adding new nodes to an array
    When TGR extends Rbel object 'phoneNumbers' at path '$phoneNumbers' by a new entry '{"type" : "home", "number" : "0176-12345566778"}'
    Then TGR asserts '!{rbelObject:serialize("phoneNumbers")}' equals '{"phoneNumbers": [{"type": "home",  "number": "030-1234567"},{"type": "work", "number": "0176-199999"},{"type" : "home", "number" : "0176-12345566778"}]}' of type JSON

    # possible use case
    Given TGR creates a new Rbel object 'PoppToken' with content '!{file("src/test/resources/data/poppToken.json")}'
    When TGR sets Rbel object 'PoppToken' at '$typ' to new value 'andere-telematik-id'
    And TGR set default header "Authorization" to "Bearer !{rbelObject:serialize('PoppToken')}"

    Given TGR send empty GET request to "http://localhost:8090/rbelbuilder"
    When TGR find next request to path "/rbelbuilder"