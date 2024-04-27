Feature: Certificar end point registro

  Background:
    * url urlBase
    * def body = call read ('classpath:resources/json/auth/bodyregistro.json')

  Scenario Outline: caso 1 verificar registro exitoso
    Given path  '/api/register'
    And  request body
    When method post
    Then status 200
    And match response.data.nombre == "Cristhian Flores"
    * def tokenresgistro = response.access_token
    * print tokenresgistro
    * print response
    Examples:
      |read('classpath:resources/csv/auth/datadrivenregistro.csv')|

  Scenario Outline: caso 2 verificar registro usuario ya existente
    Given path  '/api/register'
    And  request body
    When method post
    Then status 500
    And match response.email[0] == "The email has already been taken."
    Examples:
      |read('classpath:resources/csv/auth/datadrivenregistro.csv')|
