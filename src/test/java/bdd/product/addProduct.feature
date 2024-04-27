Feature: Certificar end point registro

    Background:
        * def featurelogueo = call read("classpath:bdd/auth/loginAuth.feature@name=login")
        * def tokenlogin = featurelogueo.token
        * print tokenlogin
        * url urlBase
        * header Accept = "application/json"
        * def body = call read ('classpath:resources/json/auth/bodyactualizarproducto.json')
        * header Authorization = 'Bearer ' + tokenlogin

    Scenario Outline: caso 1 Actualizar producto de manera satisfactoria para el producto id 5 actualizar precio stock y nombre
        Given path  '/api/v1/producto/5'
        And  request body
        When method put
        Then status 200
        * print response
        And match response.nombre == "Producto v6"
        And match response.precio == "130.00"
        And match response.stock == "1200"
        Examples:
            |read('classpath:resources/csv/auth/ddupdateprod.csv')|

    Scenario Outline: caso 2 Enviar una actualizacion de un producto no existente
        Given path  '/api/v1/producto/26554881135'
        And  request body
        When method put
        Then status 500
        And match response.error == "Call to a member function update() on null"
        * print response.error
        Examples:
            |read('classpath:resources/csv/auth/datadrivenaddproductor.csv')|

