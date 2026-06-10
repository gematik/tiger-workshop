Feature: Hello World
  Scenario: is everything up and running
    Given TGR show banner "Hello World!"

  Scenario Outline: This is a scenario outline <var>
    Given TGR set local variable "hello" to "myTest"
    Given TGR zeige Banner "${hello}"
    Given TGR zeige Banner "${demo.user.name}"
    Given TGR zeige Banner "Hello <var>"

    @ExampleTag
    Examples:
      | var        |
      | life       |
      | ${hello}   |
      | ${demo.user.name} |