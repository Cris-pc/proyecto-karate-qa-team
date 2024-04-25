Feature: Certificar feature logueo

  Background:
    * url 'https://api-ventas.synnexaconsulting.com'

  Scenario: caso 1 verificar logueo exitoso
    Given path  '/api/login'
    And form field email = 'carlosz@gmail.com'
    And form field password = '12345678'
    When method post
    Then status 200
    And match response.message == "HiCarlos Santos"
    And match response.access_token == "#string"
    And match response.user.nombre == "Carlos Santos"

  Scenario: caso 1 verificar logueo contraseña incorrecta
    Given path  '/api/login'
    And form field email = 'carlosz@gmail.com'
    And form field password = '11010101'
    When method post
    Then status 401


