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
IF OBJECT_ID('GDD_EXPRESS.BI_Escuderia', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Escuderia
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



---------------------------------------------------
-- EJECUCION DE STORED PROCEDURES
---------------------------------------------------
PRINT 'Realizando la migracion del modelo BI' + CHAR(13)
GO

-- Tablas de dimensiones
EXECUTE GDD_EXPRESS.migracion_bi_escuderia;

-- Tablas de hechos

GO

--------------------------------------------------- 
-- CREACION DE VISTAS
---------------------------------------------------
--1
CREATE VIEW [N&M'S].vw_max_tiempo_fuera_de_servicio AS
    SELECT BOT.camion_id 'camion', TMP.cuatrimestre, MAX(BOT.maximo_tiempo_fuera_servicio) 'maximo_tiempo_fuera_de_servicio'
    FROM [N&M'S].bi_Ordenes_Trabajo BOT
        INNER JOIN [N&M'S].bi_Tiempo TMP on TMP.tiempo_id = BOT.tiempo_id
    GROUP BY BOT.camion_id, TMP.cuatrimestre
GO



--------------------------------------------------- 
-- SELECCION DE VISTAS
---------------------------------------------------

-- 1
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