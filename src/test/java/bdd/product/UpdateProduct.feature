Feature: Certificar end point registro

    Background:
        * def featurelogueo = call read("classpath:bdd/auth/loginAuth.feature@name=login")
        * def tokenlogin = featurelogueo.token
        * print tokenlogin
        * url urlBase
        * header Accept = "application/json"
        * def body = call read ('classpath:resources/json/auth/bodyagregarproducto.json')
        * header Authorization = 'Bearer ' + tokenlogin

    Scenario Outline: caso 1 Certificar ingreso de producto de manera exitosa
        Given path  '/api/v1/producto'
        And  request body
        When method post
        Then status 200
        And match response.nombre == "ALTERNADOR PL200NS"
        And match response.medida == "#string"
        And match response.descripcion == "#string"
        Examples:
            |read('classpath:resources/csv/auth/datadrivenaddproductor.csv')|

    Scenario Outline: caso 2 Certificar ingreso de producto ya existente
        Given path  '/api/v1/producto'
        And  request body
        When method post
        Then status 500
        And match response.error == "#string"
        * print response.error
        Examples:
            |read('classpath:resources/csv/auth/datadrivenaddproductor.csv')|

    Scenario Outline: Caso 3 Certificar ingreso de producto sin campo requerido en codigo de producto
        Given path  '/api/v1/producto'
        And  request
        """
         {
           "codigo": "",
           "nombre": <nombre>,
           "medida": <medida>,
           "marca": <marca>,
           "categoria": <categoria>,
           "precio": <precio>,
           "stock": <stock>,
           "estado": <estado>,
           "descripcion": <descripcion>
         }
        """
        When method post
        Then status 500
        And match response.codigo[0] == "The codigo field is required."
        * print response
        Examples:
            | nombre                | medida | marca    | categoria | precio  | stock | estado | descripcion          |
            | ALTERNADOR PL200NS    | UND    | Generico | Repuestos | 20.00   | 12    |  3     |  ALTERNADOR PL200NS  |


    Scenario Outline: Caso 4 Certificar ingreso de producto sin campo requerido en codigo descripcion
        Given path  '/api/v1/producto'
        And  request
        """
         {
           "codigo": "797979",
           "nombre": <nombre>,
           "medida": <medida>,
           "marca": <marca>,
           "categoria": <categoria>,
           "precio": <precio>,
           "stock": <stock>,
           "estado": <estado>,
           "descripcion": <descripcion>
         }
        """
        When method post
        Then status 500
        And match response.nombre[0] == "The nombre field is required."
        * print response
        Examples:
            | nombre | medida | marca    | categoria | precio  | stock | estado | descripcion          |
            |        | UND    | Generico | Repuestos | 20.00   | 12    |  3     |  ALTERNADOR PL200NS  |