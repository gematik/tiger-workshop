Feature: Tiger - Workshop - Login
  Background:
    Given TGR clear recorded messages

  Scenario: Login as unregistered user, then login fails
    Given Initialisiere Nutzer "user123" mit Passwort "password"
    Given Der Nutzer fuehrt ein Login mit Name "user123" aus
    
