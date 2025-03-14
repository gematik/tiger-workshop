Feature: Tiger - Workshop

  Scenario: Call health check
    Given I control the health endpoint
    And TGR find first request to path "/service/status"
    Then TGR current response body matches:
    """
    OK
    """
