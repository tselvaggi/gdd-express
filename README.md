# DOCUMENTACION

[Link al DER](https://app.diagrams.net/#G1OgLCCYXOa4u9ZgsM51B6l_VoZCs3KTN9)

### REFERENCIA DEL DER

- En rojo las tablas que fueron creadas por script (por ahora todas sin constraint)
- En amarillo las tablas que cumplen rojo y se ideó un select para obtener las columnas y filas necesarias.
- En verde las tablas que pudieron hacerse insert del select generado en amarillo.

### 31/05/2022
- Se crearon los select que traen las tablas de parámetros
- Se creó el script que genera todas las tablas. Admiten NULL en todas las filas y no están hechas las CONSTRAINTS (PK y FK).

- Se agregó una PRIMARY KEY a Auto_Carrera, con el fin de no tener que utilizar AUTO_ID y CARRERA_ID en todas las tablas. Ahora únicamente se usará AUTO_CARRERA_ID. (No está reflejado en el DER).

### 3/6/2022
- TODO: Recordar que surgió idea de trigger para limitar la cantidad de autos que tiene una escudería.
- TODO: Función que traiga id de tablas parametros.
- Se migraron las tablas Auto, Escudería, Piloto, Carrera, Circuito y Sector (+ tablas parametros que necesite c/u)

### 4/6/2022

- Pudimos relevar que todos los neumáticos que fueron cambiados, también fueron medidos por telemetría. Por lo que concluímos en que todos los neumáticos para la tabla `Neumatico` pueden ser extraídos de la telemetría.

```sql
    --AMBAS CONSULTAS DAN LA MISMA CANTIDAD DE COLUMNAS.

    SELECT distinct TELE_NEUMATICO1_NRO_SERIE, AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA FROM gd_esquema.Maestra
    WHERE TELE_NEUMATICO1_NRO_SERIE IS NOT NULL AND TELE_NEUMATICO1_NRO_SERIE IN (
    SELECT distinct NEUMATICO1_NRO_SERIE_NUEVO FROM gd_esquema.Maestra
    WHERE NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL)

    SELECT distinct NEUMATICO1_NRO_SERIE_NUEVO FROM gd_esquema.Maestra
    WHERE NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL

```

- Se migraron tablas Auto_Carrera y sus componentes