USE [GD1C2022]
GO

--------------------------------------------------- 
-- CHEQUEO DE STORED PROCEDURES DEL MODELO BI
---------------------------------------------------
IF OBJECT_ID('GDD_EXPRESS.migracion_bi_escuderia', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_escuderia
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_bi_componentes', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_componentes
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_bi_auto', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_auto
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_bi_circuito', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_circuito
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_bi_vueltas', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_vueltas
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_bi_tiempo', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_tiempo

IF OBJECT_ID('GDD_EXPRESS.migracion_desgaste', 'P') IS NOT NULL
DROP PROCEDURE GDD_EXPRESS.migracion_desgaste

--------------------------------------------------- 
-- CHEQUEO DE FUNCIONES
---------------------------------------------------
IF OBJECT_ID('GDD_EXPRESS.fn_cuatrimestre', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_cuatrimestre
GO

--------------------------------------------------- 
-- CHEQUEO DE VISTAS DEL MODELO BI
---------------------------------------------------

--------------------------------------------------- 
-- CHEQUEO DE TABLAS DEL MODELO BI
---------------------------------------------------
-- Tablas de hechos
IF OBJECT_ID('GDD_EXPRESS.BI_Desgaste', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Desgaste
GO

-- Tablas de dimension
IF OBJECT_ID('GDD_EXPRESS.BI_Auto', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Auto
GO
IF OBJECT_ID('GDD_EXPRESS.BI_Escuderia', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Escuderia
GO

IF OBJECT_ID('GDD_EXPRESS.BI_Componente', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Componente
GO

IF OBJECT_ID('GDD_EXPRESS.BI_Circuito', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Circuito
GO

IF OBJECT_ID('GDD_EXPRESS.BI_Vuelta', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Vuelta
GO

IF OBJECT_ID('GDD_EXPRESS.BI_Tiempo', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Tiempo
GO


--------------------------------------------------- 
-- CREACION DE TABLAS DEL MODELO BI
---------------------------------------------------

-- TABLAS DE DIMENSION
CREATE TABLE GDD_EXPRESS.BI_Escuderia
(
ESCUDERIA_ID					int, --PK
ESCUDERIA_NOMBRE				nvarchar(255),
ESCUDERIA_PAIS					nvarchar(255)
PRIMARY KEY (ESCUDERIA_ID)
)
GO

CREATE TABLE GDD_EXPRESS.BI_Componente
(
COMPONENTE_ID					int IDENTITY(1,1), --PK
COMPONENTE_NRO_SERIE			nvarchar(50),
COMPONENTE_TIPO					nvarchar(255)
-- duda con la foreing key de auto?	
PRIMARY KEY (COMPONENTE_ID)
)
GO

CREATE TABLE GDD_EXPRESS.BI_Auto
(
AUTO_ID							int, --PK
AUTO_MODELO						nvarchar(255),
AUTO_ESCUDERIA_ID				int, --FK
AUTO_NUMERO						int
PRIMARY KEY (AUTO_ID)
FOREIGN KEY (AUTO_ESCUDERIA_ID) REFERENCES GDD_EXPRESS.BI_Escuderia (ESCUDERIA_ID)
)
GO

CREATE TABLE GDD_EXPRESS.BI_Circuito
(
CIRCUITO_ID							int, --PK
CIRCUITO_NOMBRE						nvarchar(255),
CIRCUITO_PAIS						nvarchar(255)
PRIMARY KEY (CIRCUITO_ID)
)
GO

CREATE TABLE GDD_EXPRESS.BI_Vuelta
(
VUELTA_ID							int IDENTITY(1,1), --PK
VUELTA_NUMERO						decimal(18,0),
PRIMARY KEY (VUELTA_ID)
)
GO


CREATE TABLE GDD_EXPRESS.BI_Tiempo
(
TIEMPO_ID							int IDENTITY(1,1), --PK
TIEMPO_ANIO							decimal(18,0),
TIEMPO_CUATRIMESTRE					decimal(18,0),
PRIMARY KEY (TIEMPO_ID)
)
GO

-- TABLAS DE HECHOS

CREATE TABLE GDD_EXPRESS.BI_Desgaste
(
DESGASTE_ID							int IDENTITY(1,1), --PK
AUTO_ID								int, --FK
COMPONENTE_ID						int, --FK
VUELTA_ID							int, --FK
CIRCUITO_ID							int, --FK
TIEMPO_ID							int, --FK
DESGASTE							decimal(18,6)
-- ------> ver si hace falta la pk
PRIMARY KEY (DESGASTE_ID)
FOREIGN KEY (AUTO_ID) REFERENCES GDD_EXPRESS.BI_Auto (AUTO_ID),
FOREIGN KEY (COMPONENTE_ID) REFERENCES GDD_EXPRESS.BI_Componente (COMPONENTE_ID),
FOREIGN KEY (CIRCUITO_ID) REFERENCES GDD_EXPRESS.BI_Circuito (CIRCUITO_ID),
FOREIGN KEY (TIEMPO_ID) REFERENCES GDD_EXPRESS.BI_Tiempo (TIEMPO_ID)
)
GO

-- -----> FALTA STORE PROCEDURE DESGASTE





---------------------------------------------------
-- CREACION DE FUNCIONES
---------------------------------------------------
CREATE FUNCTION GDD_EXPRESS.fn_cuatrimestre (@fecha as date)
RETURNS int
BEGIN
	declare @cuatri int
	SET @cuatri = CASE
		WHEN MONTH(@fecha) <5 THEN 1
		WHEN MONTH(@fecha) <9 AND MONTH(@fecha) >=5 THEN  2
		WHEN MONTH(@fecha) <13 AND MONTH(@fecha) >=9 THEN 3
    ELSE NULL
	END
	RETURN @cuatri
END
GO


--------------------------------------------------- 
-- CREACION DE STORED PROCEDURES DEL MODELO BI
---------------------------------------------------

-- Tablas de dimension

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_escuderia AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Escuderia (escuderia_id, escuderia_nombre, escuderia_pais)
            SELECT es.ESCUDERIA_ID, es.ESCUDERIA_NOMBRE, pais.PAIS_DETALLE FROM GDD_EXPRESS.Escuderia es
			JOIN GDD_EXPRESS.Pais pais ON es.ESCUDERIA_PAIS_ID = pais.PAIS_ID
    END
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_componentes AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Componente (componente_nro_serie, componente_tipo)
            SELECT DISTINCT m.MOTOR_NRO_SERIE, 'MOTOR' FROM GDD_EXPRESS.Motor m
		INSERT INTO GDD_EXPRESS.BI_Componente (componente_nro_serie, componente_tipo)
            SELECT DISTINCT c.CAJA_NRO_SERIE, 'CAJA CAMBIOS' FROM GDD_EXPRESS.Caja_Cambios c
		INSERT INTO GDD_EXPRESS.BI_Componente (componente_nro_serie, componente_tipo)
            SELECT DISTINCT n.NEUMATICO_NRO_SERIE, 'NEUMATICO' FROM GDD_EXPRESS.Neumatico n
		INSERT INTO GDD_EXPRESS.BI_Componente (componente_nro_serie, componente_tipo)
            SELECT DISTINCT f.FRENO_NRO_SERIE, 'FRENO' FROM GDD_EXPRESS.Freno f
    END
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_auto AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Auto (auto_id, auto_modelo, auto_escuderia_id, auto_numero)
            SELECT AUTO_ID, AUTO_MODELO, AUTO_ESCUDERIA_ID, AUTO_NUMERO FROM GDD_EXPRESS.Auto
    END
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_circuito AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Circuito (circuito_id, circuito_nombre, circuito_pais)
           SELECT c.CIRCUITO_ID, c.CIRCUITO_NOMBRE, pais.PAIS_DETALLE FROM GDD_EXPRESS.Circuito c
			JOIN GDD_EXPRESS.Pais pais ON c.CIRCUITO_PAIS_ID = pais.PAIS_ID
    END
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_vueltas AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Vuelta(VUELTA_NUMERO)
           SELECT DISTINCT TELE_NUMERO_DE_VUELTA FROM GDD_EXPRESS.Telemetria 
		   ORDER BY TELE_NUMERO_DE_VUELTA
    END
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_tiempo AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Tiempo(TIEMPO_ANIO, TIEMPO_CUATRIMESTRE)
		-- NO SE COMO FILTRAR LOS REPETIDOS
           SELECT YEAR(CARRERA_FECHA), GDD_EXPRESS.fn_cuatrimestre(CARRERA_FECHA) FROM GDD_EXPRESS.Carrera
    END
GO

-- Tablas de hechos
CREATE PROCEDURE GDD_EXPRESS.migracion_desgaste AS
    BEGIN
	-- NEUMATICO
		INSERT INTO GDD_EXPRESS.BI_Desgaste(
			AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID
		--- FALTA ALGUNA FUNCION PARA CALCULAR EL DESGASTE DEL NEUMATICO
		)

		SELECT a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID -- + cuenta desgaste
		FROM GDD_EXPRESS.Telemetria_Neumatico tn
		JOIN GDD_EXPRESS.Neumatico n ON n.NEUMATICO_ID = tn.NEUMATICO_ID
		JOIN GDD_EXPRESS.BI_Componente co ON co.COMPONENTE_NRO_SERIE = n.NEUMATICO_NRO_SERIE
		JOIN GDD_EXPRESS.Telemetria t ON t.TELE_ID = tn.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac ON ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
		JOIN GDD_EXPRESS.Auto a ON a.AUTO_ID = ac.AUTO_ID
		JOIN GDD_EXPRESS.Carrera c ON c.CARRERA_ID = ac.CARRERA_ID
		JOIN GDD_EXPRESS.BI_Vuelta v ON v.VUELTA_NUMERO = t.TELE_NUMERO_DE_VUELTA
		JOIN GDD_EXPRESS.Sector s ON s.SECTOR_ID = t.TELE_SECTOR_ID
		JOIN GDD_EXPRESS.Circuito ci ON ci.CIRCUITO_ID = s.SECTOR_CIRCUITO_ID
		JOIN GDD_EXPRESS.BI_Tiempo ti ON ti.TIEMPO_ANIO = YEAR(c.CARRERA_FECHA) AND ti.TIEMPO_CUATRIMESTRE = GDD_EXPRESS.fn_cuatrimestre(c.CARRERA_FECHA)
		GROUP BY a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID
		-- FRENOS
		INSERT INTO GDD_EXPRESS.BI_Desgaste(
			AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID
		--- FALTA ALGUNA FUNCION PARA CALCULAR EL DESGASTE DEL FRENO, CREO AGRUPAR POR VUELTA Y TODO ESO Y SACAR LA RESTA ENTRE PRIMERA Y ULTIMA
		)
			
		SELECT a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID
		FROM GDD_EXPRESS.Telemetria_Freno tf
		JOIN GDD_EXPRESS.Freno f ON f.FRENO_ID = tf.FRENO_ID
		JOIN GDD_EXPRESS.BI_Componente co ON co.COMPONENTE_NRO_SERIE = f.FRENO_NRO_SERIE
		JOIN GDD_EXPRESS.Telemetria t ON t.TELE_ID = tf.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac ON ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
		JOIN GDD_EXPRESS.Auto a ON a.AUTO_ID = ac.AUTO_ID
		JOIN GDD_EXPRESS.Carrera c ON c.CARRERA_ID = ac.CARRERA_ID
		JOIN GDD_EXPRESS.BI_Vuelta v ON v.VUELTA_NUMERO = t.TELE_NUMERO_DE_VUELTA
		JOIN GDD_EXPRESS.Sector s ON s.SECTOR_ID = t.TELE_SECTOR_ID
		JOIN GDD_EXPRESS.Circuito ci ON ci.CIRCUITO_ID = s.SECTOR_CIRCUITO_ID
		JOIN GDD_EXPRESS.BI_Tiempo ti ON ti.TIEMPO_ANIO = YEAR(c.CARRERA_FECHA) AND ti.TIEMPO_CUATRIMESTRE = GDD_EXPRESS.fn_cuatrimestre(c.CARRERA_FECHA)
		GROUP BY a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID

		-- MOTOR
		INSERT INTO GDD_EXPRESS.BI_Desgaste(
			AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID
		--- FALTA ALGUNA FUNCION PARA CALCULAR EL DESGASTE DEL MOTOR, CREO AGRUPAR POR VUELTA Y TODO ESO Y SACAR LA RESTA ENTRE PRIMERA Y ULTIMA
		)

		SELECT a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID
		FROM GDD_EXPRESS.Telemetria_Motor tm
		JOIN GDD_EXPRESS.Motor m ON m.MOTOR_ID = tm.MOTOR_ID
		JOIN GDD_EXPRESS.BI_Componente co ON co.COMPONENTE_NRO_SERIE = m.MOTOR_NRO_SERIE
		JOIN GDD_EXPRESS.Telemetria t ON t.TELE_ID = tm.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac ON ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
		JOIN GDD_EXPRESS.Auto a ON a.AUTO_ID = ac.AUTO_ID
		JOIN GDD_EXPRESS.Carrera c ON c.CARRERA_ID = ac.CARRERA_ID
		JOIN GDD_EXPRESS.BI_Vuelta v ON v.VUELTA_NUMERO = t.TELE_NUMERO_DE_VUELTA
		JOIN GDD_EXPRESS.Sector s ON s.SECTOR_ID = t.TELE_SECTOR_ID
		JOIN GDD_EXPRESS.Circuito ci ON ci.CIRCUITO_ID = s.SECTOR_CIRCUITO_ID
		JOIN GDD_EXPRESS.BI_Tiempo ti ON ti.TIEMPO_ANIO = YEAR(c.CARRERA_FECHA) AND ti.TIEMPO_CUATRIMESTRE = GDD_EXPRESS.fn_cuatrimestre(c.CARRERA_FECHA)
		GROUP BY a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID

	-- CAJA CAMBIOS
		INSERT INTO GDD_EXPRESS.BI_Desgaste(
			AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID, DESGASTE
		)

		SELECT a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID, MAX(tcc.CAJA_DESGASTE)
		FROM GDD_EXPRESS.Telemetria_Caja_Cambios tcc
		JOIN GDD_EXPRESS.Caja_Cambios cc ON cc.CAJA_ID = tcc.CAJA_ID
		JOIN GDD_EXPRESS.BI_Componente co ON co.COMPONENTE_NRO_SERIE = cc.CAJA_NRO_SERIE
		JOIN GDD_EXPRESS.Telemetria t ON t.TELE_ID = tcc.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac ON ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
		JOIN GDD_EXPRESS.Auto a ON a.AUTO_ID = ac.AUTO_ID
		JOIN GDD_EXPRESS.Carrera c ON c.CARRERA_ID = ac.CARRERA_ID
		JOIN GDD_EXPRESS.BI_Vuelta v ON v.VUELTA_NUMERO = t.TELE_NUMERO_DE_VUELTA
		JOIN GDD_EXPRESS.Sector s ON s.SECTOR_ID = t.TELE_SECTOR_ID
		JOIN GDD_EXPRESS.Circuito ci ON ci.CIRCUITO_ID = s.SECTOR_CIRCUITO_ID
		JOIN GDD_EXPRESS.BI_Tiempo ti ON ti.TIEMPO_ANIO = YEAR(c.CARRERA_FECHA) AND ti.TIEMPO_CUATRIMESTRE = GDD_EXPRESS.fn_cuatrimestre(c.CARRERA_FECHA)
		GROUP BY a.AUTO_ID, co.COMPONENTE_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID
    END
GO


---------------------------------------------------
-- EJECUCION DE STORED PROCEDURES
---------------------------------------------------
PRINT 'Realizando la migracion del modelo BI' + CHAR(13)
GO

-- Tablas de dimensiones
EXECUTE GDD_EXPRESS.migracion_bi_escuderia;
EXECUTE GDD_EXPRESS.migracion_bi_componentes;
EXECUTE GDD_EXPRESS.migracion_bi_auto;
EXECUTE GDD_EXPRESS.migracion_bi_circuito;
EXECUTE GDD_EXPRESS.migracion_bi_vueltas;
EXECUTE GDD_EXPRESS.migracion_bi_tiempo;
EXECUTE GDD_EXPRESS.migracion_desgaste;

-- Tablas de hechos

GO

--------------------------------------------------- 
-- CREACION DE VISTAS
---------------------------------------------------
--1
/*
CREATE VIEW [N&M'S].vw_max_tiempo_fuera_de_servicio AS
    SELECT BOT.camion_id 'camion', TMP.cuatrimestre, MAX(BOT.maximo_tiempo_fuera_servicio) 'maximo_tiempo_fuera_de_servicio'
    FROM [N&M'S].bi_Ordenes_Trabajo BOT
        INNER JOIN [N&M'S].bi_Tiempo TMP on TMP.tiempo_id = BOT.tiempo_id
    GROUP BY BOT.camion_id, TMP.cuatrimestre
GO

*/

--------------------------------------------------- 
-- SELECCION DE VISTAS
---------------------------------------------------

-- 1
/*
SELECT * FROM [N&M'S].vw_max_tiempo_fuera_de_servicio


BEGIN
    DECLARE @id_test BIT = 1

    IF @id_test = 1
		BEGIN
        PRINT 'Corre todo, pero no se carga nada (schema, tablas, sp, etc...)'
        ROLLBACK TRANSACTION
    END
	ELSE
		BEGIN
        PRINT 'Fin con exito'
        COMMIT TRANSACTION
    END
END
GO
*/