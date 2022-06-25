USE [GD1C2022]
GO

--------------------------------------------------- 
-- CHEQUEO DE STORED PROCEDURES DEL MODELO BI
---------------------------------------------------

--------------------------------------------------- 
-- CHEQUEO DE FUNCIONES
---------------------------------------------------

--------------------------------------------------- 
-- CHEQUEO DE VISTAS DEL MODELO BI
---------------------------------------------------

--------------------------------------------------- 
-- CHEQUEO DE TABLAS DEL MODELO BI
---------------------------------------------------
-- Tablas de hechos

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
-- duda con la foreing key de auto?	
PRIMARY KEY (AUTO_ID)
FOREIGN KEY (AUTO_ESCUDERIA_ID) REFERENCES GDD_EXPRESS.BI_Escuderia (ESCUDERIA_ID)
)
GO


-- TABLAS DE HECHOS


---------------------------------------------------
-- CREACION DE FUNCIONES
---------------------------------------------------



--------------------------------------------------- 
-- CREACION DE STORED PROCEDURES DEL MODELO BI
---------------------------------------------------

-- Tablas de dimension
IF OBJECT_ID('GDD_EXPRESS.migracion_bi_escuderia', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_escuderia
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_escuderia AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Escuderia (escuderia_id, escuderia_nombre, escuderia_pais)
            SELECT es.ESCUDERIA_ID, es.ESCUDERIA_NOMBRE, pais.PAIS_DETALLE FROM GDD_EXPRESS.Escuderia es
			JOIN GDD_EXPRESS.Pais pais ON es.ESCUDERIA_PAIS_ID = pais.PAIS_ID
    END
GO


IF OBJECT_ID('GDD_EXPRESS.migracion_bi_componentes', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_componentes
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

IF OBJECT_ID('GDD_EXPRESS.migracion_bi_auto', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_bi_auto
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_auto AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Auto (auto_id, auto_modelo, auto_escuderia_id, auto_numero)
            SELECT AUTO_ID, AUTO_MODELO, AUTO_ESCUDERIA_ID, AUTO_NUMERO FROM GDD_EXPRESS.Auto
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