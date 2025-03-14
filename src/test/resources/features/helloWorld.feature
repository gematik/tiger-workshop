Feature: Hello World
  Scenario: is everything up and running
    Given TGR show banner "Hello World!"

  Scenario Outline:  Test <color> with "${my.string}"
    And TGR show <color> text "${my.string}"
    Examples: We use this data only for testing data variant display in workflow ui, there is no deeper sense in it
      | color  |
      | red    |
      | blue   |