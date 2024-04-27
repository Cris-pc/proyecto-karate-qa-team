Feature: Certificar end point registro

    Background:
        * def featurelogueo = call read("classpath:bdd/auth/loginAuth.feature@name=login")
        * def tokenlogin = featurelogueo.token
        * url urlBase
        * header Accept = "application/json"
        * header Authorization = 'Bearer ' + tokenlogin


    Scenario: caso 1 Obtener listado de producto con id 20 y validar que este sea de nombre CABLE ASCELERADOR PL200NS, validar el precio sea 5
        Given path  '/api/v1/producto/20'
        When method get
        Then status 200
        * print response
        And match response.nombre == "CABLE ASCELERADOR PL200NS"
        And match response.precio == "5.00"


    Scenario: caso 2 listar todos los productos existentes
        Given path  '/api/v1/producto'
        When method get
        Then status 200
        * print response

