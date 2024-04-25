Feature: Certificar end point logueo

  Background:
    * url 'https://api-ventas.synnexaconsulting.com'
    * def body = call read ('classpath:resources/json/auth/bodyLogin.json')

  Scenario: caso 1 verificar logueo exitoso
    Given path  '/api/login'
    And form field email = 'carlosz@gmail.com'
    And form field password = '12345678'
    When method post
    Then status 200
    * def token = response.access_token
    * print token
    And match response.message == "HiCarlos Santos"
    And match response.access_token == "#string"
    And match response.user.nombre == "Carlos Santos"

  Scenario Outline: caso 2 verificar logueo contraseña incorrecta
    Given path  '/api/login'
    And  request body
    When method post
    Then status 401
    And match response.message == "Datos incorrectos"
    Examples:
      |read('classpath:resources/csv/auth/datadrivenlogintest.csv')|


