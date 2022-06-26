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
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_desgaste', 'P') IS NOT NULL
	DROP PROCEDURE GDD_EXPRESS.migracion_desgaste
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_medicion', 'P') IS NOT NULL
	DROP PROCEDURE GDD_EXPRESS.migracion_medicion
GO


--------------------------------------------------- 
-- CHEQUEO DE FUNCIONES
---------------------------------------------------
IF OBJECT_ID('GDD_EXPRESS.fn_cuatrimestre', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_cuatrimestre
GO

IF OBJECT_ID('GDD_EXPRESS.fn_tiempo_id', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_tiempo_id
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

IF OBJECT_ID('GDD_EXPRESS.BI_Medicion_Vuelta', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.BI_Medicion_Vuelta
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
TIPO_SECTOR_ID						int, --FK
TIEMPO_ID							int, --FK
DESGASTE							decimal(18,6)
-- ------> ver si hace falta la pk
PRIMARY KEY (DESGASTE_ID)
FOREIGN KEY (AUTO_ID) REFERENCES GDD_EXPRESS.BI_Auto (AUTO_ID),
FOREIGN KEY (VUELTA_ID) REFERENCES GDD_EXPRESS.BI_Vuelta (VUELTA_ID),
FOREIGN KEY (COMPONENTE_ID) REFERENCES GDD_EXPRESS.BI_Componente (COMPONENTE_ID),
FOREIGN KEY (CIRCUITO_ID) REFERENCES GDD_EXPRESS.BI_Circuito (CIRCUITO_ID),
FOREIGN KEY (TIEMPO_ID) REFERENCES GDD_EXPRESS.BI_Tiempo (TIEMPO_ID)
)
GO

CREATE TABLE GDD_EXPRESS.BI_Medicion_Vuelta
(
MEDICION_ID							int IDENTITY(1,1), --PK
ESCUDERIA_ID						int, --FK
VUELTA_ID							int, --FK
CIRCUITO_ID							int, --FK
TIEMPO_ID							int, --FK
AUTO_ID								int, --FK
COMBUSTIBLE_CONSUMIDO				decimal(18,2),
TIEMPO_VUELTA						decimal(18,10)
-- ------> ver si hace falta la pk
PRIMARY KEY (MEDICION_ID)
FOREIGN KEY (AUTO_ID) REFERENCES GDD_EXPRESS.BI_Auto (AUTO_ID),
FOREIGN KEY (ESCUDERIA_ID) REFERENCES GDD_EXPRESS.BI_Escuderia (ESCUDERIA_ID),
FOREIGN KEY (VUELTA_ID) REFERENCES GDD_EXPRESS.BI_Componente (COMPONENTE_ID),
FOREIGN KEY (CIRCUITO_ID) REFERENCES GDD_EXPRESS.BI_Circuito (CIRCUITO_ID),
FOREIGN KEY (TIEMPO_ID) REFERENCES GDD_EXPRESS.BI_Tiempo (TIEMPO_ID)
)
GO




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

CREATE FUNCTION GDD_EXPRESS.fn_tiempo_id(@fecha as date)
RETURNS int
BEGIN
	declare @tiempo_id int

	SET @tiempo_id = (SELECT t.TIEMPO_ID FROM GDD_EXPRESS.BI_Tiempo t 
	WHERE t.TIEMPO_ANIO = YEAR(@fecha) AND t.TIEMPO_CUATRIMESTRE = GDD_EXPRESS.fn_cuatrimestre(@fecha))

	RETURN @tiempo_id
END
GO



CREATE FUNCTION GDD_EXPRESS.fn_vuelta_id(@nro_vuelta as int)
RETURNS int
BEGIN
	declare @vuelta_id int

	SET @vuelta_id = (SELECT v.VUELTA_ID FROM GDD_EXPRESS.BI_Vuelta v WHERE v.VUELTA_NUMERO = @nro_vuelta)

	RETURN @vuelta_id
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
/*
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
*/

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
    END
GO

CREATE PROCEDURE GDD_EXPRESS.migracion_bi_tiempo AS
    BEGIN
        INSERT INTO GDD_EXPRESS.BI_Tiempo(TIEMPO_ANIO, TIEMPO_CUATRIMESTRE)
           SELECT distinct YEAR(CARRERA_FECHA), GDD_EXPRESS.fn_cuatrimestre(CARRERA_FECHA) FROM GDD_EXPRESS.Carrera
    END
GO

-- Tablas de hechos
CREATE PROCEDURE GDD_EXPRESS.migracion_desgaste AS
    BEGIN

	declare @bi_componente_id int

	--NEUMATICOS
	INSERT INTO GDD_EXPRESS.BI_Componente(COMPONENTE_TIPO)
	VALUES ('NEUMATICO')
	SET @bi_componente_id = @@IDENTITY

	INSERT INTO GDD_EXPRESS.BI_Desgaste(AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID, DESGASTE)
	SELECT ac.AUTO_ID, @bi_componente_id, GDD_EXPRESS.fn_vuelta_id(t.TELE_NUMERO_DE_VUELTA), c.CARRERA_CIRCUITO_ID , GDD_EXPRESS.fn_tiempo_id(c.CARRERA_FECHA), 
		MAX(tn.NEUMATICO_PROFUNDIDAD) - MIN(tn.NEUMATICO_PROFUNDIDAD) 
		FROM GDD_EXPRESS.Telemetria t
		JOIN GDD_EXPRESS.Telemetria_Neumatico tn on t.TELE_ID = tn.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID 
		JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID 
		WHERE t.TELE_POSICION <> 0
		GROUP BY t.TELE_NUMERO_DE_VUELTA, c.CARRERA_CIRCUITO_ID, c.CARRERA_FECHA, ac.AUTO_ID, tn.NEUMATICO_ID 


	--FRENOS
	INSERT INTO GDD_EXPRESS.BI_Componente(COMPONENTE_TIPO)
	VALUES ('FRENO')
	SET @bi_componente_id = @@IDENTITY

	INSERT INTO GDD_EXPRESS.BI_Desgaste(AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID, DESGASTE)
	SELECT ac.AUTO_ID, @bi_componente_id, GDD_EXPRESS.fn_vuelta_id(t.TELE_NUMERO_DE_VUELTA), c.CARRERA_CIRCUITO_ID , GDD_EXPRESS.fn_tiempo_id(c.CARRERA_FECHA), 
		MAX(tf.FRENO_GROSOR_PASTILLA) - MIN(tf.FRENO_GROSOR_PASTILLA) 
		FROM GDD_EXPRESS.Telemetria t
		JOIN GDD_EXPRESS.Telemetria_Freno tf on t.TELE_ID = tf.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID 
		JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID 
		WHERE t.TELE_POSICION <> 0
		GROUP BY t.TELE_NUMERO_DE_VUELTA, c.CARRERA_CIRCUITO_ID, c.CARRERA_FECHA, ac.AUTO_ID, tf.FRENO_ID

	--CAJA CAMBIOS
	INSERT INTO GDD_EXPRESS.BI_Componente(COMPONENTE_TIPO)
	VALUES('CAJA CAMBIOS')
	SET @bi_componente_id = @@IDENTITY

	INSERT INTO GDD_EXPRESS.BI_Desgaste(AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID, DESGASTE)
	SELECT ac.AUTO_ID, @bi_componente_id, GDD_EXPRESS.fn_vuelta_id(t.TELE_NUMERO_DE_VUELTA), c.CARRERA_CIRCUITO_ID , GDD_EXPRESS.fn_tiempo_id(c.CARRERA_FECHA), 
		MAX(tcc.CAJA_DESGASTE) - MIN(tcc.CAJA_DESGASTE) 
		FROM GDD_EXPRESS.Telemetria t
		JOIN GDD_EXPRESS.Telemetria_Caja_Cambios tcc on t.TELE_ID = tcc.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID 
		JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID 
		WHERE t.TELE_POSICION <> 0
		GROUP BY t.TELE_NUMERO_DE_VUELTA, c.CARRERA_CIRCUITO_ID, c.CARRERA_FECHA, ac.AUTO_ID, tcc.CAJA_ID

	--MOTOR

	INSERT INTO GDD_EXPRESS.BI_Componente(COMPONENTE_TIPO)
	VALUES('MOTOR')
	SET @bi_componente_id = @@IDENTITY

	INSERT INTO GDD_EXPRESS.BI_Desgaste(AUTO_ID, COMPONENTE_ID, VUELTA_ID, CIRCUITO_ID, TIEMPO_ID, DESGASTE)
	SELECT ac.AUTO_ID, @bi_componente_id, GDD_EXPRESS.fn_vuelta_id(t.TELE_NUMERO_DE_VUELTA), c.CARRERA_CIRCUITO_ID , GDD_EXPRESS.fn_tiempo_id(c.CARRERA_FECHA), 
		MAX(tm.MOTOR_POTENCIA) - MIN(tm.MOTOR_POTENCIA) 
		FROM GDD_EXPRESS.Telemetria t
		JOIN GDD_EXPRESS.Telemetria_Motor tm on t.TELE_ID = tm.TELE_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID 
		JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID 
		WHERE t.TELE_POSICION <> 0
		GROUP BY t.TELE_NUMERO_DE_VUELTA, c.CARRERA_CIRCUITO_ID, c.CARRERA_FECHA, ac.AUTO_ID, tm.MOTOR_ID
    END
GO


CREATE PROCEDURE GDD_EXPRESS.migracion_medicion AS
    BEGIN
		INSERT INTO GDD_EXPRESS.BI_Medicion_Vuelta( ESCUDERIA_ID, VUELTA_ID, CIRCUITO_ID, 
		TIEMPO_ID, AUTO_ID, COMBUSTIBLE_CONSUMIDO, TIEMPO_VUELTA
		)

		SELECT e.ESCUDERIA_ID, v.VUELTA_ID, ci.CIRCUITO_ID, ti.TIEMPO_ID, a.AUTO_ID,
		(SELECT MAX(TELE_COMBUSTIBLE) - MIN(TELE_COMBUSTIBLE) FROM GDD_EXPRESS.Telemetria
			JOIN GDD_EXPRESS.BI_Vuelta vu ON vu.VUELTA_NUMERO = TELE_NUMERO_DE_VUELTA
			WHERE vu.VUELTA_ID = v.VUELTA_ID 
			-- NO FUNCIONA EL AND PORQUE USO AUTO EN VEZ DE AUTO_CARRERA
			--AND TELE_AUTO_CARRERA_ID=ac.AUTO_CARRERA_ID
		) AS COMBUSTIBLE_CONSUMIDO,
		(SELECT MAX(TELE_TIEMPO_DE_VUELTA) FROM GDD_EXPRESS.Telemetria 
			JOIN GDD_EXPRESS.BI_Vuelta vu ON vu.VUELTA_NUMERO = TELE_NUMERO_DE_VUELTA
			WHERE vu.VUELTA_ID = v.VUELTA_ID 
			-- NO FUNCIONA EL AND PORQUE USO AUTO EN VEZ DE AUTO_CARRERA
			--AND TELE_AUTO_CARRERA_ID=ac.AUTO_CARRERA_ID
		) as TIEMPO_VUELTA
		FROM GDD_EXPRESS.BI_Escuderia e
		JOIN GDD_EXPRESS.BI_Auto a on a.AUTO_ESCUDERIA_ID = e.ESCUDERIA_ID
		JOIN GDD_EXPRESS.Auto_Carrera ac ON ac.AUTO_ID = a.AUTO_ID
		JOIN GDD_EXPRESS.Carrera ca on ca.CARRERA_ID = ac.CARRERA_ID
		JOIN GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
		JOIN GDD_EXPRESS.BI_Circuito ci on ci.CIRCUITO_ID=ca.CARRERA_CIRCUITO_ID
		JOIN GDD_EXPRESS.BI_Tiempo ti ON ti.TIEMPO_ANIO = YEAR(ca.CARRERA_FECHA) AND ti.TIEMPO_CUATRIMESTRE = GDD_EXPRESS.fn_cuatrimestre(ca.CARRERA_FECHA)
		JOIN GDD_EXPRESS.BI_Vuelta v ON v.VUELTA_NUMERO = tel.TELE_NUMERO_DE_VUELTA
		GROUP BY e.ESCUDERIA_ID, v.VUELTA_ID, ci.CIRCUITO_ID, a.AUTO_ID, ti.TIEMPO_ID
		ORDER BY a.AUTO_ID	
	END
GO

---------------------------------------------------
-- EJECUCION DE STORED PROCEDURES
---------------------------------------------------
PRINT 'Realizando la migracion del modelo BI' + CHAR(13)
GO

-- Tablas de dimensiones
EXECUTE GDD_EXPRESS.migracion_bi_tiempo
EXECUTE GDD_EXPRESS.migracion_bi_escuderia;
EXECUTE GDD_EXPRESS.migracion_bi_auto;
EXECUTE GDD_EXPRESS.migracion_bi_circuito;
EXECUTE GDD_EXPRESS.migracion_bi_vueltas;
EXECUTE GDD_EXPRESS.migracion_desgaste;
--EXECUTE GDD_EXPRESS.migracion_medicion;

SELECT a.AUTO_MODELO, c.COMPONENTE_TIPO, v.VUELTA_NUMERO, cir.CIRCUITO_NOMBRE, avg(d.DESGASTE) as promedio_desgaste FROM GDD_EXPRESS.BI_Desgaste d
JOIN GDD_EXPRESS.BI_Componente c on c.COMPONENTE_ID = d.COMPONENTE_ID
JOIN GDD_EXPRESS.BI_Auto a on a.AUTO_ID = d.AUTO_ID
JOIN GDD_EXPRESS.BI_Vuelta v on v.VUELTA_ID = d.VUELTA_ID
JOIN GDD_EXPRESS.BI_Circuito cir on cir.CIRCUITO_ID = d.CIRCUITO_ID
GROUP BY d.CIRCUITO_ID, d.VUELTA_ID, v.VUELTA_NUMERO, cir.CIRCUITO_NOMBRE, a.AUTO_MODELO, c.COMPONENTE_TIPO
order by cir.CIRCUITO_NOMBRE, v.VUELTA_NUMERO, a.AUTO_MODELO

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