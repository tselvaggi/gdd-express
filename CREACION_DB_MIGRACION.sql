USE [GD1C2022]
GO
-- CREACION ESQUEMA --
IF not exists (select * from sys.schemas where name = 'GDD_EXPRESS')
BEGIN
	exec ('CREATE SCHEMA GDD_EXPRESS')
END
GO

-- DROP DE LAS TABLAS --

IF OBJECT_ID('GDD_EXPRESS.Telemetria_Neumatico', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Telemetria_Neumatico

IF OBJECT_ID('GDD_EXPRESS.Telemetria_Freno', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Telemetria_Freno

IF OBJECT_ID('GDD_EXPRESS.Telemetria_Caja_Cambios', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Telemetria_Caja_Cambios

IF OBJECT_ID('GDD_EXPRESS.Telemetria_Motor', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Telemetria_Motor

IF OBJECT_ID('GDD_EXPRESS.Telemetria', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Telemetria

IF OBJECT_ID('GDD_EXPRESS.Cambio_Neumatico', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Cambio_Neumatico

IF OBJECT_ID('GDD_EXPRESS.Box_Parada', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Box_Parada

IF OBJECT_ID('GDD_EXPRESS.Freno', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Freno

IF OBJECT_ID('GDD_EXPRESS.Neumatico', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Neumatico

IF OBJECT_ID('GDD_EXPRESS.Neumatico_Tipo', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Neumatico_Tipo

IF OBJECT_ID('GDD_EXPRESS.Posicion', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Posicion

IF OBJECT_ID('GDD_EXPRESS.Caja_Cambios', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Caja_Cambios

IF OBJECT_ID('GDD_EXPRESS.Motor', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Motor

IF OBJECT_ID('GDD_EXPRESS.Incidente_Auto_Carrera', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Incidente_Auto_Carrera

IF OBJECT_ID('GDD_EXPRESS.Incidente', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Incidente

IF OBJECT_ID('GDD_EXPRESS.Incidente_Bandera', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Incidente_Bandera

IF OBJECT_ID('GDD_EXPRESS.Incidente_Tipo', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Incidente_Tipo

IF OBJECT_ID('GDD_EXPRESS.Auto_Carrera', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Auto_Carrera

IF OBJECT_ID('GDD_EXPRESS.Carrera', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Carrera

IF OBJECT_ID('GDD_EXPRESS.Clima', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Clima

IF OBJECT_ID('GDD_EXPRESS.Sector', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Sector

IF OBJECT_ID('GDD_EXPRESS.Sector_Tipo', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Sector_Tipo

IF OBJECT_ID('GDD_EXPRESS.Circuito', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Circuito

IF OBJECT_ID('GDD_EXPRESS.Piloto', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Piloto

IF OBJECT_ID('GDD_EXPRESS.Auto', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Auto

IF OBJECT_ID('GDD_EXPRESS.Escuderia', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Escuderia

IF OBJECT_ID('GDD_EXPRESS.Pais', 'U') IS NOT NULL
	DROP TABLE GDD_EXPRESS.Pais

-- CREACION DE LAS TABLAS --

CREATE TABLE GDD_EXPRESS.Pais
(
PAIS_ID					int IDENTITY(1,1), --PK
PAIS_DETALLE				nvarchar(255),
PRIMARY KEY (PAIS_ID)
)

CREATE TABLE GDD_EXPRESS.Escuderia
(
ESCUDERIA_ID				int IDENTITY(1,1), --PK
ESCUDERIA_NOMBRE			nvarchar(255),
ESCUDERIA_PAIS_ID			int,
PRIMARY KEY(ESCUDERIA_ID),
FOREIGN KEY (ESCUDERIA_PAIS_ID) REFERENCES GDD_EXPRESS.Pais (PAIS_ID)
)


CREATE TABLE GDD_EXPRESS.Auto
(
AUTO_ID					int IDENTITY(1,1), --PK
AUTO_MODELO				nvarchar(255),
AUTO_ESCUDERIA_ID			int, --FK
AUTO_NUMERO					int,
PRIMARY KEY (AUTO_ID),
FOREIGN KEY (AUTO_ESCUDERIA_ID) REFERENCES GDD_EXPRESS.Escuderia (ESCUDERIA_ID)
)

CREATE TABLE GDD_EXPRESS.Piloto
(
PILOTO_ID				int IDENTITY(1,1), --PK
PILOTO_AUTO_ID				int UNIQUE, --FK
PILOTO_NOMBRE				nvarchar(50),
PILOTO_APELLIDO				nvarchar(50),
PILOTO_NACIONALIDAD			int,
PILOTO_FECHA_NACIMIENTO			date,
PRIMARY KEY (PILOTO_ID),
FOREIGN KEY(PILOTO_AUTO_ID) REFERENCES GDD_EXPRESS.Auto (AUTO_ID)
)

CREATE TABLE GDD_EXPRESS.Circuito
(
CIRCUITO_ID				int, --PK
CIRCUITO_NOMBRE				nvarchar(255),
CIRCUITO_PAIS_ID			int, --FK
PRIMARY KEY (CIRCUITO_ID),
FOREIGN KEY (CIRCUITO_PAIS_ID) REFERENCES GDD_EXPRESS.Pais (PAIS_ID)
)

CREATE TABLE GDD_EXPRESS.Sector_Tipo
(
SECTOR_TIPO_ID				int IDENTITY(1,1), --PK
SECTOR_TIPO_DETALLE			nvarchar(255),
PRIMARY KEY (SECTOR_TIPO_ID)
)

CREATE TABLE GDD_EXPRESS.Sector
(
SECTOR_ID				int, --PK
SECTOR_DISTANCIA			decimal(18,2), 
SECTOR_TIPO_ID				int, --FK
SECTOR_CIRCUITO_ID			int, --FK
PRIMARY KEY (SECTOR_ID),
FOREIGN KEY (SECTOR_TIPO_ID) REFERENCES GDD_EXPRESS.Sector_Tipo (SECTOR_TIPO_ID),
FOREIGN KEY (SECTOR_CIRCUITO_ID) REFERENCES GDD_EXPRESS.Circuito (CIRCUITO_ID)
)

CREATE TABLE GDD_EXPRESS.Clima
(
CLIMA_ID				int IDENTITY(1,1), --PK
CLIMA_DETALLE				nvarchar(100),
PRIMARY KEY (CLIMA_ID)
)


CREATE TABLE GDD_EXPRESS.Carrera
(
CARRERA_ID				int, --PK
CARRERA_FECHA				date,
CARRERA_CLIMA_ID			int, --FK
CARRERA_CANT_VUELTAS			int,
CARRERA_CIRCUITO_ID			int, --FK
PRIMARY KEY (CARRERA_ID),
FOREIGN KEY (CARRERA_CLIMA_ID) REFERENCES GDD_EXPRESS.Clima (CLIMA_ID),
FOREIGN KEY (CARRERA_CIRCUITO_ID) REFERENCES GDD_EXPRESS.Circuito (CIRCUITO_ID)
)


CREATE TABLE GDD_EXPRESS.Auto_Carrera
(
AUTO_CARRERA_ID				int IDENTITY(1,1),
AUTO_ID					int, --PK, FK
CARRERA_ID				int, --PK, FK
PRIMARY KEY (AUTO_CARRERA_ID),
UNIQUE (AUTO_ID, CARRERA_ID),
FOREIGN KEY (AUTO_ID) REFERENCES GDD_EXPRESS.Auto (AUTO_ID),
FOREIGN KEY (CARRERA_ID) REFERENCES GDD_EXPRESS.Carrera (CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Incidente_Tipo
(
INCIDENTE_TIPO_ID			int IDENTITY(1,1), --PK
INCIDENTE_TIPO_DETALLE			varchar(255),
PRIMARY KEY (INCIDENTE_TIPO_ID)
)

CREATE TABLE GDD_EXPRESS.Incidente_Bandera
(
INCIDENTE_BANDERA_ID			int IDENTITY(1,1), --PK
INCIDENTE_BANDERA_DETALLE		varchar(255),
PRIMARY KEY (INCIDENTE_BANDERA_ID)
)

CREATE TABLE GDD_EXPRESS.Incidente
(
INCIDENTE_ID				int IDENTITY(1,1), --PK
INCIDENTE_BANDERA_ID			int, --FK
INCIDENTE_TIPO_ID			int, --FK
INCIDENTE_TIEMPO			decimal(18,2),
INCIDENTE_SECTOR_ID			int, --FK
PRIMARY KEY (INCIDENTE_ID),
FOREIGN KEY (INCIDENTE_BANDERA_ID) REFERENCES GDD_EXPRESS.Incidente_Bandera (INCIDENTE_BANDERA_ID),
FOREIGN KEY (INCIDENTE_TIPO_ID) REFERENCES GDD_EXPRESS.Incidente_Tipo (INCIDENTE_TIPO_ID)
)

CREATE TABLE GDD_EXPRESS.Incidente_Auto_Carrera
(
INCIDENTE_ID				int, --PK, FK
INCIDENTE_AUTO_CARRERA_ID		int, --PK, FK 
INCIDENTE_NUMERO_VUELTA			decimal(18,0),
PRIMARY KEY(INCIDENTE_ID, INCIDENTE_AUTO_CARRERA_ID),
FOREIGN KEY (INCIDENTE_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Motor
(
MOTOR_ID				int IDENTITY(1,1), --PK
MOTOR_AUTO_CARRERA_ID			int, --FK
MOTOR_MODELO				nvarchar(255),
MOTOR_NRO_SERIE				nvarchar(255),
PRIMARY KEY (MOTOR_ID),
FOREIGN KEY (MOTOR_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Caja_Cambios
(
CAJA_ID					int IDENTITY(1,1), --PK
CAJA_AUTO_CARRERA_ID			int, --FK
CAJA_MODELO				nvarchar(50),
CAJA_NRO_SERIE				nvarchar(255),
PRIMARY KEY (CAJA_ID),
FOREIGN KEY (CAJA_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Posicion
(
POSICION_ID				int IDENTITY(1,1), --PK
POSICION_DETALLE			nvarchar(255),
PRIMARY KEY (POSICION_ID)
)

CREATE TABLE GDD_EXPRESS.Neumatico_Tipo
(
NEUMATICO_TIPO_ID			int IDENTITY(1,1), --PK
NEUMATICO_TIPO_DETALLE			varchar(255),
PRIMARY KEY (NEUMATICO_TIPO_ID)
)

CREATE TABLE GDD_EXPRESS.Neumatico
(
NEUMATICO_ID				int IDENTITY(1,1), --PK
NEUMATICO_AUTO_CARRERA_ID		int, --FK
NEUMATICO_NRO_SERIE			nvarchar(255),
NEUMATICO_TIPO_ID			int, --FK
NEUMATICO_POSICION_ID			int, --FK
PRIMARY KEY (NEUMATICO_ID),
FOREIGN KEY (NEUMATICO_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID),
FOREIGN KEY (NEUMATICO_TIPO_ID) REFERENCES GDD_EXPRESS.Neumatico_Tipo (NEUMATICO_TIPO_ID),
FOREIGN KEY (NEUMATICO_POSICION_ID) REFERENCES GDD_EXPRESS.Posicion (POSICION_ID)
)

CREATE TABLE GDD_EXPRESS.Freno
(
FRENO_ID				int IDENTITY(1,1), --PK
FRENO_AUTO_CARRERA_ID			int, --FK
FRENO_NRO_SERIE				nvarchar(255),
FRENO_TAMANIO_DISCO				decimal(18,2),
FRENO_POSICION_ID			int,  --FK
PRIMARY KEY (FRENO_ID),
FOREIGN KEY (FRENO_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID),
FOREIGN KEY (FRENO_POSICION_ID) REFERENCES GDD_EXPRESS.Posicion (POSICION_ID)
)

CREATE TABLE GDD_EXPRESS.Box_Parada
(
BOX_PARADA_ID				int IDENTITY(1,1), --PK
BOX_AUTO_CARRERA_ID		int, --FK
BOX_PARADA_VUELTA			decimal(18,0),
BOX_PARADA_TIEMPO			decimal(18,2),
PRIMARY KEY (BOX_PARADA_ID),
FOREIGN KEY (BOX_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Cambio_Neumatico
(
CAMBIO_NEUMATICO_ID			int IDENTITY(1,1),
BOX_PARADA_ID				int, --PK, FK
NEUMATICO_NUEVO_ID				int, --PK, FK
NEUMATICO_VIEJO_ID				int,
PRIMARY KEY (CAMBIO_NEUMATICO_ID),
FOREIGN KEY (BOX_PARADA_ID) REFERENCES GDD_EXPRESS.Box_Parada (BOX_PARADA_ID),
FOREIGN KEY (NEUMATICO_NUEVO_ID) REFERENCES GDD_EXPRESS.Neumatico (NEUMATICO_ID),
FOREIGN KEY (NEUMATICO_VIEJO_ID) REFERENCES GDD_EXPRESS.Neumatico (NEUMATICO_ID)
)

CREATE TABLE GDD_EXPRESS.Telemetria
(
TELE_ID					int, --PK
TELE_AUTO_CARRERA_ID			int, --FK
TELE_SECTOR_ID				int, --FK
TELE_NUMERO_DE_VUELTA			decimal(18,0),
TELE_DISTANCIA_VUELTA			decimal(18,2),
TELE_TIEMPO_DE_VUELTA			decimal(18,10),
TELE_POSICION				decimal(18,0),
TELE_VELOCIDAD_AUTO			decimal(18,2),
TELE_COMBUSTIBLE			decimal(18,2),
PRIMARY KEY (TELE_ID),
FOREIGN KEY (TELE_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID),
FOREIGN KEY (TELE_SECTOR_ID) REFERENCES GDD_EXPRESS.Sector (SECTOR_ID)
)


CREATE TABLE GDD_EXPRESS.Telemetria_Motor
(
TELE_MOTOR_ID				int IDENTITY(1,1), --PK
TELE_ID					int, --FK
MOTOR_POTENCIA				decimal(18,2),
MOTOR_RPM				decimal(18,2),
MOTOR_TEMP_ACEITE			decimal(18,2),
MOTOR_TEMP_AGUA				decimal(18,2),
MOTOR_ID				int, --FK
PRIMARY KEY (TELE_MOTOR_ID),
FOREIGN KEY (TELE_ID) REFERENCES GDD_EXPRESS.Telemetria (TELE_ID),
FOREIGN KEY (MOTOR_ID) REFERENCES GDD_EXPRESS.Motor (MOTOR_ID)
)

CREATE TABLE GDD_EXPRESS.Telemetria_Caja_Cambios
(
TELE_CAJA_ID				int IDENTITY(1,1), --PK
TELE_ID					int, --FK
CAJA_TEMP_ACEITE			decimal(18,2),
CAJA_RPM				decimal(18,2),
CAJA_DESGASTE				decimal(18,2),
CAJA_ID					int, --FK
PRIMARY KEY (TELE_CAJA_ID),
FOREIGN KEY (TELE_ID) REFERENCES GDD_EXPRESS.Telemetria (TELE_ID),
FOREIGN KEY (CAJA_ID) REFERENCES GDD_EXPRESS.Caja_Cambios (CAJA_ID)
)

CREATE TABLE GDD_EXPRESS.Telemetria_Freno
(
TELE_FRENO_ID				int IDENTITY(1,1), --PK
TELE_ID					int, --FK
FRENO_GROSOR_PASTILLA			decimal(18,2),
FRENO_TEMPERATURA			decimal(18,2),
FRENO_ID				int, --FK
PRIMARY KEY (TELE_FRENO_ID),
FOREIGN KEY (TELE_ID) REFERENCES GDD_EXPRESS.Telemetria (TELE_ID),
FOREIGN KEY (FRENO_ID) REFERENCES GDD_EXPRESS.Freno (FRENO_ID)
)

CREATE TABLE GDD_EXPRESS.Telemetria_Neumatico
(
TELE_NEUMATICO_ID			int IDENTITY(1,1), --PK
TELE_ID					int, --FK
NEUMATICO_PRESION			decimal(18,6),
NEUMATICO_PROFUNDIDAD			decimal(18,6),
NEUMATICO_TEMPERATURA			decimal(18,6),
NEUMATICO_ID				int, --FK
PRIMARY KEY (TELE_NEUMATICO_ID),
FOREIGN KEY (TELE_ID) REFERENCES GDD_EXPRESS.Telemetria (TELE_ID),
FOREIGN KEY (NEUMATICO_ID) REFERENCES GDD_EXPRESS.Neumatico (NEUMATICO_ID)
)	

-- FUNCTIONS --

IF OBJECT_ID('GDD_EXPRESS.fn_id_auto_carrera', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_id_auto_carrera
GO


GO
CREATE FUNCTION GDD_EXPRESS.fn_id_auto_carrera (@auto_modelo as nvarchar(255), @auto_numero as int, @codigo_carrera as int)
RETURNS int
BEGIN
	declare @id_auto int
	declare @id_auto_carrera int

	SET @id_auto = GDD_EXPRESS.fn_id_auto(@auto_modelo, @auto_numero)

	SET @id_auto_carrera = (SELECT ac.AUTO_CARRERA_ID FROM GDD_EXPRESS.Auto_Carrera ac WHERE ac.CARRERA_ID = @codigo_carrera AND ac.AUTO_ID = @id_auto)
	
	RETURN @id_auto_carrera
END
GO

IF OBJECT_ID('GDD_EXPRESS.fn_id_neumatico', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_id_neumatico
GO


GO
CREATE FUNCTION GDD_EXPRESS.fn_id_neumatico (@neumatico_nro_serie as nvarchar(255))
RETURNS int
BEGIN
	declare @id_neumatico int

	SET @id_neumatico = (SELECT n.NEUMATICO_ID FROM GDD_EXPRESS.Neumatico n WHERE n.NEUMATICO_NRO_SERIE = @neumatico_nro_serie)
	
	RETURN @id_neumatico
END
GO

IF OBJECT_ID('GDD_EXPRESS.fn_id_pais', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_id_pais
GO


GO
CREATE FUNCTION GDD_EXPRESS.fn_id_pais (@nacionalidad as nvarchar(255))
RETURNS int
BEGIN
	declare @id_pais int

	SET @id_pais = (select p.PAIS_ID from GDD_EXPRESS.Pais p WHERE p.PAIS_DETALLE = @nacionalidad)
	
	RETURN @id_pais
END
GO

IF OBJECT_ID('GDD_EXPRESS.fn_id_auto', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_id_auto
GO


GO
CREATE FUNCTION GDD_EXPRESS.fn_id_auto (@auto_modelo as nvarchar(255), @auto_numero as int)
RETURNS int
BEGIN
	declare @id_auto int

	SET @id_auto = (SELECT a.AUTO_ID FROM GDD_EXPRESS.Auto a WHERE a.AUTO_MODELO = @auto_modelo AND a.AUTO_NUMERO = @auto_numero)
	
	RETURN @id_auto
END
GO

IF OBJECT_ID('GDD_EXPRESS.fn_id_clima', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_id_clima
GO


GO
CREATE FUNCTION GDD_EXPRESS.fn_id_clima (@carrera_clima as varchar(100))
RETURNS int
BEGIN
	declare @id_clima int

	SET @id_clima = (select c.CLIMA_ID from GDD_EXPRESS.Clima c WHERE c.CLIMA_DETALLE = @carrera_clima)
	
	RETURN @id_clima
END
GO

IF OBJECT_ID('GDD_EXPRESS.fn_id_sector_tipo', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_id_sector_tipo
GO


GO
CREATE FUNCTION GDD_EXPRESS.fn_id_sector_tipo (@sector_tipo as varchar(100))
RETURNS int
BEGIN
	declare @id_sector_tipo int

	SET @id_sector_tipo = (select p.SECTOR_TIPO_ID from GDD_EXPRESS.Sector_Tipo p WHERE p.SECTOR_TIPO_DETALLE = @sector_tipo)
	
	RETURN @id_sector_tipo
END
GO

IF OBJECT_ID('GDD_EXPRESS.fn_id_posicion', 'FN') IS NOT NULL
	DROP FUNCTION GDD_EXPRESS.fn_id_posicion
GO


GO
CREATE FUNCTION GDD_EXPRESS.fn_id_posicion (@detalle_posicion as nvarchar(255))
RETURNS int
BEGIN
	declare @id_posicion int

	SET @id_posicion = (SELECT p.POSICION_ID FROM GDD_EXPRESS.Posicion p WHERE p.POSICION_DETALLE = @detalle_posicion)
	
	RETURN @id_posicion
END
GO


-- STORE PROCEDURES --

IF OBJECT_ID('GDD_EXPRESS.migracion_parametros', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_parametros
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_parametros
AS
BEGIN

	BEGIN TRY
		BEGIN TRANSACTION

			--TABLA PAISES/NACIONALIDADES
			INSERT INTO GDD_EXPRESS.Pais (PAIS_DETALLE)
			SELECT distinct m.CIRCUITO_PAIS FROM gd_esquema.Maestra m
			where m.CIRCUITO_PAIS IS NOT NULL
			INSERT INTO GDD_EXPRESS.Pais (PAIS_DETALLE)
			SELECT distinct m.ESCUDERIA_NACIONALIDAD FROM gd_esquema.Maestra m
			where m.ESCUDERIA_NACIONALIDAD IS NOT NULL
			INSERT INTO GDD_EXPRESS.Pais (PAIS_DETALLE)
			SELECT distinct m.PILOTO_NACIONALIDAD FROM gd_esquema.Maestra m	
			where  m.PILOTO_NACIONALIDAD IS NOT NULL

			--TABLA TIPO SECTOR
			INSERT INTO GDD_EXPRESS.Sector_Tipo (SECTOR_TIPO_DETALLE)
			SELECT distinct m.SECTO_TIPO FROM gd_esquema.Maestra m
			where m.SECTO_TIPO IS NOT NULL 

			--TABLA CLIMA
			INSERT INTO GDD_EXPRESS.Clima (CLIMA_DETALLE)
			SELECT distinct m.CARRERA_CLIMA FROM gd_esquema.Maestra m
			where NOT m.CARRERA_CLIMA IS NULL 

			--TABLA INCIDENTE_TIPO
			INSERT INTO GDD_EXPRESS.Incidente_Tipo (INCIDENTE_TIPO_DETALLE)
			SELECT distinct m.INCIDENTE_TIPO FROM gd_esquema.Maestra m
			where m.INCIDENTE_TIPO IS NOT NULL

			--TABLA INCIDENTE_BANDERA
			INSERT INTO GDD_EXPRESS.Incidente_Bandera (INCIDENTE_BANDERA_DETALLE)
			SELECT distinct m.INCIDENTE_BANDERA FROM gd_esquema.Maestra m
			where m.INCIDENTE_BANDERA IS NOT NULL

			--TABLA 
			INSERT INTO GDD_EXPRESS.Posicion (POSICION_DETALLE)
			SELECT distinct m.NEUMATICO1_POSICION_NUEVO FROM gd_esquema.Maestra m
			where NOT m.NEUMATICO1_POSICION_NUEVO IS NULL
			INSERT INTO GDD_EXPRESS.Posicion (POSICION_DETALLE)
			SELECT distinct m.NEUMATICO2_POSICION_NUEVO FROM gd_esquema.Maestra m
			where NOT m.NEUMATICO2_POSICION_NUEVO IS NULL
			INSERT INTO GDD_EXPRESS.Posicion (POSICION_DETALLE)
			SELECT distinct m.NEUMATICO3_POSICION_NUEVO FROM gd_esquema.Maestra m
			where NOT m.NEUMATICO3_POSICION_NUEVO IS NULL
			INSERT INTO GDD_EXPRESS.Posicion (POSICION_DETALLE)
			SELECT distinct m.NEUMATICO4_POSICION_NUEVO FROM gd_esquema.Maestra m
			where NOT m.NEUMATICO2_POSICION_NUEVO IS NULL
		
		COMMIT TRANSACTION	
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLAS PARAMETROS';
        THROW 50002, @errorDescripcion, 1
	END CATCH
		
END
GO  


IF OBJECT_ID('GDD_EXPRESS.migracion_autos_escuderias', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_autos_escuderias
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_autos_escuderias
AS
BEGIN
	DECLARE c_escuderia CURSOR FOR
		SELECT distinct ESCUDERIA_NOMBRE, ESCUDERIA_NACIONALIDAD FROM gd_esquema.Maestra
		where ESCUDERIA_NOMBRE IS NOT NULL
		
	
	CREATE TABLE #t_autos(
		AUTO_MODELO nvarchar(255),
		AUTO_NUMERO int,
		ESCUDERIA_NOMBRE nvarchar(255)
	)

	BEGIN TRY
	BEGIN TRANSACTION

		INSERT INTO #t_autos
			SELECT distinct m.AUTO_MODELO, m.AUTO_NUMERO, m.ESCUDERIA_NOMBRE FROM gd_esquema.Maestra m
			where m.AUTO_MODELO IS NOT NULL

		declare @escuderia_nombre nvarchar(255)
		declare @escuderia_nacionalidad nvarchar(255)

		OPEN c_escuderia
		FETCH NEXT FROM c_escuderia INTO @escuderia_nombre, @escuderia_nacionalidad
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			declare @id_pais int
			declare @id_escuderia int
			declare @id_auto int

			SET @id_pais = GDD_EXPRESS.fn_id_pais_escuderia(@escuderia_nacionalidad)

			INSERT INTO GDD_EXPRESS.Escuderia (ESCUDERIA_NOMBRE, ESCUDERIA_PAIS_ID)
			VALUES (@escuderia_nombre, @id_pais)

			SET @id_escuderia = @@IDENTITY

			INSERT INTO GDD_EXPRESS.Auto (AUTO_MODELO, AUTO_NUMERO, AUTO_ESCUDERIA_ID)
				SELECT ta.AUTO_MODELO, ta.AUTO_NUMERO, @id_escuderia FROM #t_autos ta
				WHERE ta.ESCUDERIA_NOMBRE = (SELECT esc.ESCUDERIA_NOMBRE FROM GDD_EXPRESS.Escuderia esc
				WHERE esc.ESCUDERIA_ID = @id_escuderia)

			FETCH NEXT FROM c_escuderia INTO @escuderia_nombre, @escuderia_nacionalidad

		END

		CLOSE c_escuderia  
		DEALLOCATE c_escuderia 
	COMMIT TRANSACTION	
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLAS AUTO, ESCUDERIA';
        THROW 50000, @errorDescripcion, 1
	END CATCH
		
END
GO  

IF OBJECT_ID('GDD_EXPRESS.migracion_pilotos', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_pilotos
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_pilotos
AS
BEGIN
	DECLARE c_pilotos CURSOR FOR
		SELECT distinct m.PILOTO_NOMBRE, m.PILOTO_APELLIDO, m.PILOTO_NACIONALIDAD, m.PILOTO_FECHA_NACIMIENTO, m.AUTO_MODELO, m.AUTO_NUMERO FROM gd_esquema.Maestra m
		

	BEGIN TRY
	BEGIN TRANSACTION

		declare @pilo_nombre nvarchar(50)
		declare @pilo_apellido nvarchar(50)
		declare @pilo_nacionalidad nvarchar(50)
		declare @pilo_fecha_nacimiento date
		declare @auto_modelo nvarchar(255)
		declare @auto_numero int

		OPEN c_pilotos
		FETCH NEXT FROM c_pilotos INTO @pilo_nombre, @pilo_apellido, @pilo_nacionalidad, @pilo_fecha_nacimiento, @auto_modelo, @auto_numero
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			declare @id_pais int
			declare @id_auto int

			SET @id_pais = GDD_EXPRESS.fn_id_pais(@pilo_nacionalidad)

			SET @id_auto = GDD_EXPRESS.fn_id_auto(@auto_modelo, @auto_numero)

			INSERT INTO GDD_EXPRESS.Piloto (PILOTO_NOMBRE, PILOTO_APELLIDO, PILOTO_FECHA_NACIMIENTO, PILOTO_NACIONALIDAD, PILOTO_AUTO_ID)
			VALUES (@pilo_nombre, @pilo_apellido, @pilo_fecha_nacimiento, @id_pais,  @id_auto)
			

			FETCH NEXT FROM c_pilotos INTO @pilo_nombre, @pilo_apellido, @pilo_nacionalidad, @pilo_fecha_nacimiento, @auto_modelo, @auto_numero

		END

		CLOSE c_pilotos  
		DEALLOCATE c_pilotos 
	COMMIT TRANSACTION	
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLA PILOTO';
        THROW 50001, @errorDescripcion, 1
	END CATCH
		
END
GO  

IF OBJECT_ID('GDD_EXPRESS.migracion_carrera', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_carrera
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_carrera
AS
BEGIN
	DECLARE c_circuito_carrera CURSOR FOR
		SELECT distinct CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_FECHA, CARRERA_CANT_VUELTAS, 
		CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS FROM gd_esquema.Maestra



	declare @id_pais int
	declare @id_clima int

	BEGIN TRY
	BEGIN TRANSACTION
		declare @codigo_carrera int
		declare @carrera_clima varchar(100)
		declare @carrera_fecha date
		declare @carrera_cantidad_vueltas int
		declare @circuito_codigo int
		declare @circuito_nombre varchar(255)
		declare @circuito_pais varchar(255)

		OPEN c_circuito_carrera
		FETCH NEXT FROM c_circuito_carrera INTO @codigo_carrera, @carrera_clima, @carrera_fecha, @carrera_cantidad_vueltas, @circuito_codigo, @circuito_nombre, @circuito_pais
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			
			

			SET @id_pais = GDD_EXPRESS.fn_id_pais(@circuito_pais)
			SET @id_clima = GDD_EXPRESS.fn_id_clima(@carrera_clima)

			INSERT INTO GDD_EXPRESS.Circuito(CIRCUITO_ID, CIRCUITO_NOMBRE, CIRCUITO_PAIS_ID)
			VALUES (@circuito_codigo, @circuito_nombre, @id_pais)

			INSERT INTO GDD_EXPRESS.Carrera(CARRERA_ID, CARRERA_CLIMA_ID, CARRERA_FECHA, CARRERA_CANT_VUELTAS, CARRERA_CIRCUITO_ID)
			VALUES (@codigo_carrera, @id_clima, @carrera_fecha, @carrera_cantidad_vueltas, @circuito_codigo)

			
			FETCH NEXT FROM c_circuito_carrera INTO @codigo_carrera, @carrera_clima, @carrera_fecha, @carrera_cantidad_vueltas, @circuito_codigo, @circuito_nombre, @circuito_pais

		END

		CLOSE c_circuito_carrera  
		DEALLOCATE c_circuito_carrera 

		
		DECLARE c_sector CURSOR FOR
		SELECT distinct CODIGO_SECTOR, SECTOR_DISTANCIA, SECTO_TIPO, CIRCUITO_CODIGO FROM gd_esquema.Maestra

		declare @codigo_sector int
		declare @sector_distancia decimal(18,2)
		declare @sector_tipo varchar(255)
		
	
		OPEN c_sector
		FETCH NEXT FROM c_sector INTO @codigo_sector, @sector_distancia, @sector_tipo, @circuito_codigo
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			declare @id_sector_tipo int

			SET @id_sector_tipo = GDD_EXPRESS.fn_id_sector_tipo(@sector_tipo)

			INSERT INTO GDD_EXPRESS.Sector(SECTOR_ID, SECTOR_DISTANCIA, SECTOR_TIPO_ID, SECTOR_CIRCUITO_ID)
			VALUES (@codigo_sector, @sector_distancia, @id_sector_tipo, @circuito_codigo)

			FETCH NEXT FROM c_sector INTO @codigo_sector, @sector_distancia, @sector_tipo, @circuito_codigo

		END

		CLOSE c_sector  
		DEALLOCATE c_sector 

	COMMIT TRANSACTION	
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLAS CARRERA, CIRCUITO, SECTORES';
        THROW 50000, @errorDescripcion, 1
	END CATCH
		
END
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_auto_carrera', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_auto_carrera
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_auto_carrera
AS
BEGIN
	DECLARE c_circuito_carrera CURSOR FOR
		SELECT distinct CODIGO_CARRERA, CARRERA_CLIMA, CARRERA_FECHA, CARRERA_CANT_VUELTAS, 
		CIRCUITO_CODIGO, CIRCUITO_NOMBRE, CIRCUITO_PAIS FROM gd_esquema.Maestra



	declare @id_pais int
	declare @id_clima int

	BEGIN TRY
	BEGIN TRANSACTION
		declare @codigo_carrera int
		declare @carrera_clima varchar(100)
		declare @carrera_fecha date
		declare @carrera_cantidad_vueltas int
		declare @circuito_codigo int
		declare @circuito_nombre varchar(255)
		declare @circuito_pais varchar(255)

		OPEN c_circuito_carrera
		FETCH NEXT FROM c_circuito_carrera INTO @codigo_carrera, @carrera_clima, @carrera_fecha, @carrera_cantidad_vueltas, @circuito_codigo, @circuito_nombre, @circuito_pais
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			
			

			SET @id_pais =  GDD_EXPRESS.fn_id_pais(@circuito_pais)
			SET @id_clima = GDD_EXPRESS.fn_id_clima(@carrera_clima)

			INSERT INTO GDD_EXPRESS.Circuito(CIRCUITO_ID, CIRCUITO_NOMBRE, CIRCUITO_PAIS_ID)
			VALUES (@circuito_codigo, @circuito_nombre, @id_pais)

			INSERT INTO GDD_EXPRESS.Carrera(CARRERA_ID, CARRERA_CLIMA_ID, CARRERA_FECHA, CARRERA_CANT_VUELTAS, CARRERA_CIRCUITO_ID)
			VALUES (@codigo_carrera, @id_clima, @carrera_fecha, @carrera_cantidad_vueltas, @circuito_codigo)

			
			FETCH NEXT FROM c_circuito_carrera INTO @codigo_carrera, @carrera_clima, @carrera_fecha, @carrera_cantidad_vueltas, @circuito_codigo, @circuito_nombre, @circuito_pais

		END

		CLOSE c_circuito_carrera  
		DEALLOCATE c_circuito_carrera 

		
		DECLARE c_sector CURSOR FOR
		SELECT distinct CODIGO_SECTOR, SECTOR_DISTANCIA, SECTO_TIPO, CIRCUITO_CODIGO FROM gd_esquema.Maestra

		declare @codigo_sector int
		declare @sector_distancia decimal(18,2)
		declare @sector_tipo varchar(255)
		
	
		OPEN c_sector
		FETCH NEXT FROM c_sector INTO @codigo_sector, @sector_distancia, @sector_tipo, @circuito_codigo
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			declare @id_sector_tipo int

			SET @id_sector_tipo = GDD_EXPRESS.fn_id_sector_tipo(@sector_tipo)

			INSERT INTO GDD_EXPRESS.Sector(SECTOR_ID, SECTOR_DISTANCIA, SECTOR_TIPO_ID, SECTOR_CIRCUITO_ID)
			VALUES (@codigo_sector, @sector_distancia, @id_sector_tipo, @circuito_codigo)

			FETCH NEXT FROM c_sector INTO @codigo_sector, @sector_distancia, @sector_tipo, @circuito_codigo

		END

		CLOSE c_sector  
		DEALLOCATE c_sector 


	COMMIT TRANSACTION	
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLAS CARRERA, CIRCUITO, SECTORES';
        THROW 50005, @errorDescripcion, 1
	END CATCH
		
END
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_auto_carrera', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_auto_carrera
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_auto_carrera
AS
BEGIN
	DECLARE c_auto_carrera CURSOR FOR
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA FROM gd_esquema.Maestra
		


	BEGIN TRY
	BEGIN TRANSACTION

		declare @auto_modelo nvarchar(255)
		declare @auto_numero int 
		declare @codigo_carrera int

		declare @id_auto int
		declare @id_auto_carrera int

		-- TABLAS TEMPORALES
		CREATE TABLE #t_motor
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_MOTOR_MODELO			nvarchar(255), 
		TELE_MOTOR_NRO_SERIE			nvarchar(255)
		)

		INSERT INTO #t_motor
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_MOTOR_MODELO, TELE_MOTOR_NRO_SERIE FROM gd_esquema.Maestra
		WHERE TELE_MOTOR_NRO_SERIE IS NOT NULL

		CREATE TABLE #t_caja
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_CAJA_MODELO			nvarchar(255), 
		TELE_CAJA_NRO_SERIE			nvarchar(255)
		)

		INSERT INTO #t_caja
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_CAJA_MODELO, TELE_CAJA_NRO_SERIE FROM gd_esquema.Maestra
		WHERE TELE_CAJA_NRO_SERIE IS NOT NULL

		CREATE TABLE #t_freno
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_FRENO_NRO_SERIE			nvarchar(255), 
		TELE_FRENO_TAMANIO_DISCO			decimal(18,2),
		TELE_FRENO_POSICION				nvarchar(255)
		)

		INSERT INTO #t_freno
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_FRENO1_NRO_SERIE, TELE_FRENO1_TAMANIO_DISCO, TELE_FRENO1_POSICION FROM gd_esquema.Maestra
		WHERE TELE_FRENO1_NRO_SERIE IS NOT NULL
		INSERT INTO #t_freno
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_FRENO2_NRO_SERIE, TELE_FRENO2_TAMANIO_DISCO, TELE_FRENO2_POSICION FROM gd_esquema.Maestra
		WHERE TELE_FRENO2_NRO_SERIE IS NOT NULL
		INSERT INTO #t_freno
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_FRENO3_NRO_SERIE, TELE_FRENO3_TAMANIO_DISCO, TELE_FRENO3_POSICION FROM gd_esquema.Maestra
		WHERE TELE_FRENO3_NRO_SERIE IS NOT NULL
		INSERT INTO #t_freno
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_FRENO4_NRO_SERIE, TELE_FRENO4_TAMANIO_DISCO, TELE_FRENO4_POSICION FROM gd_esquema.Maestra
		WHERE TELE_FRENO4_NRO_SERIE IS NOT NULL
		

		CREATE TABLE #t_neumatico
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_NEUMATICO_NRO_SERIE			nvarchar(255), 
		TELE_NEUMATICO_POSICION			nvarchar(255)
		)

		INSERT INTO #t_neumatico
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_NEUMATICO1_NRO_SERIE, TELE_NEUMATICO1_POSICION FROM gd_esquema.Maestra
		WHERE TELE_NEUMATICO1_NRO_SERIE IS NOT NULL
		INSERT INTO #t_neumatico
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_NEUMATICO2_NRO_SERIE, TELE_NEUMATICO2_POSICION FROM gd_esquema.Maestra
		WHERE TELE_NEUMATICO2_NRO_SERIE IS NOT NULL
		INSERT INTO #t_neumatico
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_NEUMATICO3_NRO_SERIE, TELE_NEUMATICO3_POSICION FROM gd_esquema.Maestra
		WHERE TELE_NEUMATICO3_NRO_SERIE IS NOT NULL
		INSERT INTO #t_neumatico
		SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_NEUMATICO4_NRO_SERIE, TELE_NEUMATICO4_POSICION FROM gd_esquema.Maestra
		WHERE TELE_NEUMATICO4_NRO_SERIE IS NOT NULL
		

		CREATE TABLE #t_telemetria
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_AUTO_CODIGO		int, 
		CODIGO_SECTOR			int,
		TELE_AUTO_COMBUSTIBLE		decimal(18,2), 
		TELE_AUTO_DISTANCIA_VUELTA		decimal(18,2), 
		TELE_AUTO_NUMERO_VUELTA				decimal(18,0),
		TELE_AUTO_POSICION				decimal(18,0), 
		TELE_AUTO_TIEMPO_VUELTA			decimal(18,10),
		TELE_AUTO_VELOCIDAD				decimal(18,2)
		)

		INSERT INTO #t_telemetria
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.CODIGO_SECTOR, m.TELE_AUTO_COMBUSTIBLE, m.TELE_AUTO_DISTANCIA_VUELTA, m.TELE_AUTO_NUMERO_VUELTA, m.TELE_AUTO_POSICION, m.TELE_AUTO_TIEMPO_VUELTA,m.TELE_AUTO_VELOCIDAD
		FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL 

		CREATE TABLE #t_telemetria_caja
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_AUTO_CODIGO		int,
		TELE_CAJA_NRO_SERIE		nvarchar(255),
		TELE_CAJA_DESGASTE		decimal(18,2),
		TELE_CAJA_RPM			decimal(18,2),
		TELE_CAJA_TEMP_ACEITE		decimal(18,2)
		)

		INSERT INTO #t_telemetria_caja (AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_CAJA_NRO_SERIE, TELE_CAJA_DESGASTE, TELE_CAJA_RPM, TELE_CAJA_TEMP_ACEITE)
		SELECT tc.AUTO_MODELO, tc.AUTO_NUMERO, tc.CODIGO_CARRERA, tc.TELE_AUTO_CODIGO, tc.TELE_CAJA_NRO_SERIE, tc.TELE_CAJA_DESGASTE, tc.TELE_CAJA_RPM, tc.TELE_CAJA_TEMP_ACEITE
		FROM gd_esquema.Maestra tc
		WHERE tc.TELE_AUTO_CODIGO IS NOT NULL

		CREATE TABLE #t_telemetria_motor
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_AUTO_CODIGO		int,
		TELE_MOTOR_POTENCIA		decimal(18,2),
		TELE_MOTOR_RPM		decimal(18,2),
		TELE_MOTOR_TEMP_ACEITE			decimal(18,2),
		TELE_MOTOR_TEMP_AGUA		decimal(18,2)
		)

		INSERT INTO #t_telemetria_motor (AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_MOTOR_POTENCIA, TELE_MOTOR_RPM, TELE_MOTOR_TEMP_ACEITE, TELE_MOTOR_TEMP_AGUA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_MOTOR_POTENCIA, m.TELE_MOTOR_RPM, m.TELE_MOTOR_TEMP_ACEITE, m.TELE_MOTOR_TEMP_AGUA
		FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL

		CREATE TABLE #t_telemetria_neumaticos
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_AUTO_CODIGO			int,
		TELE_NEUMATICO_NRO_SERIE		nvarchar(255),
		TELE_NEUMATICO_PRESION		decimal(18,6),
		TELE_NEUMATICO_PROFUNDIDAD		decimal(18,6),
		TELE_NEUMATICO_TEMPERATURA			decimal(18,6)
		)

		INSERT INTO #t_telemetria_neumaticos (AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_NEUMATICO_NRO_SERIE, TELE_NEUMATICO_PRESION, TELE_NEUMATICO_PROFUNDIDAD, TELE_NEUMATICO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_NEUMATICO1_NRO_SERIE, m.TELE_NEUMATICO1_PRESION, m.TELE_NEUMATICO1_PROFUNDIDAD, m.TELE_NEUMATICO1_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL
		INSERT INTO #t_telemetria_neumaticos (AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_NEUMATICO_NRO_SERIE, TELE_NEUMATICO_PRESION, TELE_NEUMATICO_PROFUNDIDAD, TELE_NEUMATICO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_NEUMATICO2_NRO_SERIE, m.TELE_NEUMATICO2_PRESION, m.TELE_NEUMATICO2_PROFUNDIDAD, m.TELE_NEUMATICO2_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL
		INSERT INTO #t_telemetria_neumaticos (AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_NEUMATICO_NRO_SERIE, TELE_NEUMATICO_PRESION, TELE_NEUMATICO_PROFUNDIDAD, TELE_NEUMATICO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_NEUMATICO3_NRO_SERIE, m.TELE_NEUMATICO3_PRESION, m.TELE_NEUMATICO3_PROFUNDIDAD, m.TELE_NEUMATICO3_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL
		INSERT INTO #t_telemetria_neumaticos (AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_NEUMATICO_NRO_SERIE, TELE_NEUMATICO_PRESION, TELE_NEUMATICO_PROFUNDIDAD, TELE_NEUMATICO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_NEUMATICO4_NRO_SERIE, m.TELE_NEUMATICO4_PRESION, m.TELE_NEUMATICO4_PROFUNDIDAD, m.TELE_NEUMATICO4_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL

		CREATE TABLE #t_telemetria_neumaticos_auto
		(
		TELE_AUTO_CODIGO			int,
		TELE_NEUMATICO_NRO_SERIE		nvarchar(255),
		TELE_NEUMATICO_PRESION		decimal(18,6),
		TELE_NEUMATICO_PROFUNDIDAD		decimal(18,6),
		TELE_NEUMATICO_TEMPERATURA			decimal(18,6)
		)

		CREATE TABLE #t_telemetria_frenos
		(
		AUTO_MODELO				nvarchar(255), 
		AUTO_NUMERO				int, 
		CODIGO_CARRERA			int,
		TELE_AUTO_CODIGO			int,
		TELE_FRENO_NRO_SERIE		nvarchar(255),
		TELE_FRENO_GROSOR_PASTILLA		decimal(18,2),
		TELE_FRENO_TEMPERATURA		decimal(18,2)
		)

		INSERT INTO #t_telemetria_frenos(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_FRENO_NRO_SERIE, TELE_FRENO_GROSOR_PASTILLA, TELE_FRENO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_FRENO1_NRO_SERIE, m.TELE_FRENO1_GROSOR_PASTILLA, m.TELE_FRENO1_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL
		INSERT INTO #t_telemetria_frenos(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_FRENO_NRO_SERIE, TELE_FRENO_GROSOR_PASTILLA, TELE_FRENO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_FRENO2_NRO_SERIE, m.TELE_FRENO2_GROSOR_PASTILLA, m.TELE_FRENO2_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL
		INSERT INTO #t_telemetria_frenos(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_FRENO_NRO_SERIE, TELE_FRENO_GROSOR_PASTILLA, TELE_FRENO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_FRENO3_NRO_SERIE, m.TELE_FRENO3_GROSOR_PASTILLA, m.TELE_FRENO3_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL
		INSERT INTO #t_telemetria_frenos(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, TELE_AUTO_CODIGO, TELE_FRENO_NRO_SERIE, TELE_FRENO_GROSOR_PASTILLA, TELE_FRENO_TEMPERATURA)
		SELECT m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.TELE_AUTO_CODIGO, m.TELE_FRENO4_NRO_SERIE, m.TELE_FRENO4_GROSOR_PASTILLA, m.TELE_FRENO4_TEMPERATURA FROM gd_esquema.Maestra m
		WHERE m.TELE_AUTO_CODIGO IS NOT NULL

		CREATE TABLE #t_telemetria_frenos_auto
		(
		TELE_AUTO_CODIGO			int,
		TELE_FRENO_NRO_SERIE		nvarchar(255),
		TELE_FRENO_GROSOR_PASTILLA		decimal(18,2),
		TELE_FRENO_TEMPERATURA		decimal(18,2)
		)

		OPEN c_auto_carrera
		FETCH NEXT FROM c_auto_carrera INTO @auto_modelo, @auto_numero, @codigo_carrera
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			

			SET @id_auto = GDD_EXPRESS.fn_id_auto(@auto_modelo, @auto_numero)
		
			-- MIGRACION AUTO_CARRERA
			INSERT INTO GDD_EXPRESS.Auto_Carrera(AUTO_ID, CARRERA_ID)
			VALUES (@id_auto, @codigo_carrera)
			
			SET @id_auto_carrera = @@IDENTITY

			-- MIGRACION TELEMETRIA
			INSERT INTO GDD_EXPRESS.Telemetria (TELE_ID, TELE_SECTOR_ID, TELE_COMBUSTIBLE, TELE_DISTANCIA_VUELTA, TELE_NUMERO_DE_VUELTA, TELE_POSICION, TELE_TIEMPO_DE_VUELTA, TELE_VELOCIDAD_AUTO, TELE_AUTO_CARRERA_ID)
			SELECT t.TELE_AUTO_CODIGO, t.CODIGO_SECTOR, t.TELE_AUTO_COMBUSTIBLE, t.TELE_AUTO_DISTANCIA_VUELTA, t.TELE_AUTO_NUMERO_VUELTA, t.TELE_AUTO_POSICION, t.TELE_AUTO_TIEMPO_VUELTA, t.TELE_AUTO_VELOCIDAD, @id_auto_carrera 
			FROM #t_telemetria t
			WHERE t.AUTO_MODELO = @auto_modelo AND t.AUTO_NUMERO = @auto_numero AND t.CODIGO_CARRERA = @codigo_carrera

			-- MIGRACION MOTOR
			INSERT INTO GDD_EXPRESS.Motor (MOTOR_AUTO_CARRERA_ID, MOTOR_MODELO, MOTOR_NRO_SERIE)
			SELECT @id_auto_carrera, m.TELE_MOTOR_MODELO, m.TELE_MOTOR_NRO_SERIE FROM #t_motor m
			WHERE m.AUTO_MODELO = @auto_modelo 
			AND m.AUTO_NUMERO = @auto_numero 
			AND m.CODIGO_CARRERA = @codigo_carrera
			
			declare @id_motor int

			SET @id_motor = @@IDENTITY

			INSERT INTO GDD_EXPRESS.Telemetria_Motor(TELE_ID, MOTOR_ID, MOTOR_POTENCIA, MOTOR_RPM, MOTOR_TEMP_ACEITE, MOTOR_TEMP_AGUA)
			SELECT m.TELE_AUTO_CODIGO, @id_motor, m.TELE_MOTOR_POTENCIA, m.TELE_MOTOR_RPM, m.TELE_MOTOR_TEMP_ACEITE, m.TELE_MOTOR_TEMP_AGUA
			FROM #t_telemetria_motor m
			WHERE m.AUTO_MODELO = @auto_modelo AND m.AUTO_NUMERO = @auto_numero AND m.CODIGO_CARRERA = @codigo_carrera


			-- MIGRACION CAJA CAMBIOS
			INSERT INTO GDD_EXPRESS.Caja_Cambios (CAJA_AUTO_CARRERA_ID, CAJA_MODELO, CAJA_NRO_SERIE)
			SELECT @id_auto_carrera, c.TELE_CAJA_MODELO, c.TELE_CAJA_NRO_SERIE FROM #t_caja c
			WHERE c.AUTO_MODELO = @auto_modelo 
			AND c.AUTO_NUMERO = @auto_numero 
			AND c.CODIGO_CARRERA = @codigo_carrera

			declare @id_caja_cambios int

			SET @id_caja_cambios = @@IDENTITY

			INSERT INTO GDD_EXPRESS.Telemetria_Caja_Cambios (TELE_ID, CAJA_ID, CAJA_DESGASTE, CAJA_RPM, CAJA_TEMP_ACEITE)
			SELECT tc.TELE_AUTO_CODIGO, @id_caja_cambios, tc.TELE_CAJA_DESGASTE, tc.TELE_CAJA_RPM, tc.TELE_CAJA_TEMP_ACEITE
			FROM #t_telemetria_caja tc
			WHERE tc.AUTO_MODELO = @auto_modelo AND tc.AUTO_NUMERO = @auto_numero AND tc.CODIGO_CARRERA = @codigo_carrera

			-- MIGRACION FRENOS
			DECLARE c_freno_auto_carrera CURSOR FOR
				SELECT distinct f.TELE_FRENO_NRO_SERIE, f.TELE_FRENO_POSICION, f.TELE_FRENO_TAMANIO_DISCO FROM #t_freno f
				WHERE f.AUTO_MODELO = @auto_modelo 
				AND f.AUTO_NUMERO = @auto_numero 
				AND f.CODIGO_CARRERA = @codigo_carrera

			INSERT INTO #t_telemetria_frenos_auto (TELE_AUTO_CODIGO, TELE_FRENO_NRO_SERIE, TELE_FRENO_GROSOR_PASTILLA, TELE_FRENO_TEMPERATURA)
			SELECT f.TELE_AUTO_CODIGO, f.TELE_FRENO_NRO_SERIE, f.TELE_FRENO_GROSOR_PASTILLA, f.TELE_FRENO_TEMPERATURA FROM #t_telemetria_frenos f
			WHERE f.AUTO_MODELO = @auto_modelo 
			AND f.AUTO_NUMERO = @auto_numero 
			AND f.CODIGO_CARRERA = @codigo_carrera


			declare @freno_nro_serie nvarchar(255)
			declare @freno_posicion nvarchar(255)
			declare @freno_tamanio_disco decimal(18,2)
			
			declare @id_posicion int
			declare @id_freno int

			OPEN c_freno_auto_carrera
			FETCH NEXT FROM c_freno_auto_carrera INTO @freno_nro_serie, @freno_posicion, @freno_tamanio_disco
			WHILE (@@FETCH_STATUS = 0)
			BEGIN

				SET @id_posicion = GDD_EXPRESS.fn_id_posicion(@freno_posicion)
				
				INSERT INTO GDD_EXPRESS.Freno (FRENO_AUTO_CARRERA_ID, FRENO_NRO_SERIE, FRENO_POSICION_ID, FRENO_TAMANIO_DISCO)
				VALUES (@id_auto_carrera, @freno_nro_serie, @id_posicion, @freno_tamanio_disco)

				SET @id_freno = @@IDENTITY

				INSERT INTO GDD_EXPRESS.Telemetria_Freno(TELE_ID, FRENO_ID, FRENO_GROSOR_PASTILLA, FRENO_TEMPERATURA)
				SELECT fa.TELE_AUTO_CODIGO, @id_freno, fa.TELE_FRENO_GROSOR_PASTILLA, fa.TELE_FRENO_TEMPERATURA FROM #t_telemetria_frenos_auto fa
				WHERE fa.TELE_FRENO_NRO_SERIE = @freno_nro_serie

				FETCH NEXT FROM c_freno_auto_carrera INTO @freno_nro_serie, @freno_posicion, @freno_tamanio_disco
			END
			CLOSE c_freno_auto_carrera  
			DEALLOCATE c_freno_auto_carrera

			-- MIGRACION NEUMATICOS
			DECLARE c_neumatico_auto_carrera CURSOR FOR
				SELECT distinct n.TELE_NEUMATICO_NRO_SERIE, n.TELE_NEUMATICO_POSICION FROM #t_neumatico n
				WHERE n.AUTO_MODELO = @auto_modelo 
				AND n.AUTO_NUMERO = @auto_numero 
				AND n.CODIGO_CARRERA = @codigo_carrera
			
			declare @neumatico_nro_serie nvarchar(255)
			declare @neumatico_posicion nvarchar(255)


			INSERT INTO #t_telemetria_neumaticos_auto (TELE_AUTO_CODIGO, TELE_NEUMATICO_NRO_SERIE, TELE_NEUMATICO_PRESION, TELE_NEUMATICO_PROFUNDIDAD, TELE_NEUMATICO_TEMPERATURA)
				SELECT distinct n.TELE_AUTO_CODIGO, n.TELE_NEUMATICO_NRO_SERIE, n.TELE_NEUMATICO_PRESION, n.TELE_NEUMATICO_PROFUNDIDAD, n.TELE_NEUMATICO_TEMPERATURA FROM #t_telemetria_neumaticos n
				WHERE n.AUTO_MODELO = @auto_modelo 
				AND n.AUTO_NUMERO = @auto_numero 
				AND n.CODIGO_CARRERA = @codigo_carrera
			
			declare @id_neumatico int

			OPEN c_neumatico_auto_carrera
			FETCH NEXT FROM c_neumatico_auto_carrera INTO @neumatico_nro_serie, @neumatico_posicion
			WHILE (@@FETCH_STATUS = 0)
			BEGIN

				SET @id_posicion = GDD_EXPRESS.fn_id_posicion(@neumatico_posicion)
				
				INSERT INTO GDD_EXPRESS.Neumatico(NEUMATICO_AUTO_CARRERA_ID, NEUMATICO_NRO_SERIE, NEUMATICO_POSICION_ID)
				VALUES (@id_auto_carrera, @neumatico_nro_serie, @id_posicion)

				SET @id_neumatico = @@IDENTITY

				INSERT INTO GDD_EXPRESS.Telemetria_Neumatico(TELE_ID, NEUMATICO_ID, NEUMATICO_PRESION, NEUMATICO_PROFUNDIDAD, NEUMATICO_TEMPERATURA)
				SELECT n.TELE_AUTO_CODIGO, @id_neumatico, n.TELE_NEUMATICO_PRESION, n.TELE_NEUMATICO_PROFUNDIDAD, n.TELE_NEUMATICO_TEMPERATURA FROM #t_telemetria_neumaticos_auto n
				WHERE n.TELE_NEUMATICO_NRO_SERIE = @neumatico_nro_serie

				FETCH NEXT FROM c_neumatico_auto_carrera INTO @neumatico_nro_serie, @neumatico_posicion
			END
			CLOSE c_neumatico_auto_carrera  
			DEALLOCATE c_neumatico_auto_carrera
			

			FETCH NEXT FROM c_auto_carrera INTO @auto_modelo, @auto_numero, @codigo_carrera

		END

		CLOSE c_auto_carrera  
		DEALLOCATE c_auto_carrera
	COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLAS AUTO_CARRERA Y COMPONENTES';
        THROW 50001, @errorDescripcion, 1
	END CATCH
		
END
GO

IF OBJECT_ID('GDD_EXPRESS.migracion_incidentes', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_incidentes
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_incidentes
AS
BEGIN
	CREATE TABLE #t_incidentes
	(
	AUTO_MODELO				nvarchar(255), 
	AUTO_NUMERO				int, 
	CODIGO_CARRERA			int,
	CODIGO_SECTOR			int,
	INCIDENTE_NUMERO_VUELTA				decimal(18,0),
	INCIDENTE_BANDERA			nvarchar(255),
	INCIDENTE_TIPO				nvarchar(255),
	INCIDENTE_TIEMPO				decimal(18,2)
	)

	INSERT INTO #t_incidentes
	SELECT distinct AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, CODIGO_SECTOR, INCIDENTE_NUMERO_VUELTA, INCIDENTE_BANDERA, INCIDENTE_TIPO, INCIDENTE_TIEMPO FROM gd_esquema.Maestra
	WHERE INCIDENTE_TIEMPO IS NOT NULL
		

	BEGIN TRY
	BEGIN TRANSACTION
	DECLARE c_incidente CURSOR FOR
	SELECT distinct i.CODIGO_SECTOR, i.INCIDENTE_BANDERA, i.INCIDENTE_TIEMPO, i.INCIDENTE_TIPO FROM #t_incidentes i

	declare @codigo_sector int
	declare @incidente_tipo nvarchar(255)
	declare @incidente_tiempo decimal(18,2)
	declare @incidente_bandera nvarchar(255)

	declare @codigo_carrera int

	OPEN c_incidente
	FETCH NEXT FROM c_incidente INTO @codigo_sector, @incidente_bandera, @incidente_tiempo, @incidente_tipo
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		declare @id_incidente int
		declare @id_incidente_tipo int
		declare @id_incidente_bandera int

		SET @id_incidente_tipo = (select i.INCIDENTE_TIPO_ID from GDD_EXPRESS.Incidente_Tipo i WHERE i.INCIDENTE_TIPO_DETALLE = @incidente_tipo)
		SET  @id_incidente_bandera = (select ib.INCIDENTE_BANDERA_ID from GDD_EXPRESS.Incidente_Bandera ib WHERE ib.INCIDENTE_BANDERA_DETALLE = @incidente_bandera)

		INSERT INTO GDD_EXPRESS.Incidente(INCIDENTE_SECTOR_ID, INCIDENTE_TIPO_ID, INCIDENTE_BANDERA_ID, INCIDENTE_TIEMPO)
		VALUES (@codigo_sector, @id_incidente_tipo, @id_incidente_bandera, @incidente_tiempo)

		SET @id_incidente = @@IDENTITY

		INSERT INTO GDD_EXPRESS.Incidente_Auto_Carrera (INCIDENTE_ID, INCIDENTE_NUMERO_VUELTA, INCIDENTE_AUTO_CARRERA_ID)
		SELECT @id_incidente, i.INCIDENTE_NUMERO_VUELTA, GDD_EXPRESS.fn_id_auto_carrera(i.AUTO_MODELO, i.AUTO_NUMERO, i.CODIGO_CARRERA)
		FROM #t_incidentes i
		WHERE i.CODIGO_SECTOR = @codigo_sector 
		AND i.INCIDENTE_TIPO = @incidente_tipo 
		AND i.INCIDENTE_BANDERA = @incidente_bandera
		AND i.INCIDENTE_TIEMPO = @incidente_tiempo

		FETCH NEXT FROM c_incidente INTO @codigo_sector, @incidente_bandera, @incidente_tiempo, @incidente_tipo

	END

	CLOSE c_incidente  
	DEALLOCATE c_incidente 
		


	COMMIT TRANSACTION	
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLA INCIDENTES';
        THROW 50001, @errorDescripcion, 1
	END CATCH
		
END
GO  

IF OBJECT_ID('GDD_EXPRESS.migracion_box', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_box
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_box
AS
BEGIN

	CREATE TABLE #t_neumatico_cambios
	(
	AUTO_MODELO				nvarchar(255), 
	AUTO_NUMERO				int, 
	CODIGO_CARRERA			int,	
	NEUMATICO_NRO_SERIE_NUEVO nvarchar(255),
	PARADA_BOX_TIEMPO decimal(18,2),
	NEUMATICO_NRO_SERIE_VIEJO nvarchar(255)
	)

	INSERT INTO #t_neumatico_cambios(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, NEUMATICO_NRO_SERIE_NUEVO, PARADA_BOX_TIEMPO,NEUMATICO_NRO_SERIE_VIEJO)
	SELECT distinct m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.NEUMATICO1_NRO_SERIE_NUEVO, m.PARADA_BOX_TIEMPO, m.NEUMATICO1_NRO_SERIE_VIEJO FROM gd_esquema.Maestra m
	WHERE m.NEUMATICO1_NRO_SERIE_NUEVO IS NOT NULL
	INSERT INTO #t_neumatico_cambios(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, NEUMATICO_NRO_SERIE_NUEVO, PARADA_BOX_TIEMPO,NEUMATICO_NRO_SERIE_VIEJO)
	SELECT distinct m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.NEUMATICO2_NRO_SERIE_NUEVO, m.PARADA_BOX_TIEMPO, m.NEUMATICO2_NRO_SERIE_VIEJO FROM gd_esquema.Maestra m
	WHERE m.NEUMATICO2_NRO_SERIE_NUEVO IS NOT NULL
	INSERT INTO #t_neumatico_cambios(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, NEUMATICO_NRO_SERIE_NUEVO, PARADA_BOX_TIEMPO,NEUMATICO_NRO_SERIE_VIEJO)
	SELECT distinct m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.NEUMATICO3_NRO_SERIE_NUEVO, m.PARADA_BOX_TIEMPO, m.NEUMATICO3_NRO_SERIE_VIEJO FROM gd_esquema.Maestra m
	WHERE m.NEUMATICO3_NRO_SERIE_NUEVO IS NOT NULL
	INSERT INTO #t_neumatico_cambios(AUTO_MODELO, AUTO_NUMERO, CODIGO_CARRERA, NEUMATICO_NRO_SERIE_NUEVO, PARADA_BOX_TIEMPO,NEUMATICO_NRO_SERIE_VIEJO)
	SELECT distinct m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.NEUMATICO4_NRO_SERIE_NUEVO, m.PARADA_BOX_TIEMPO, m.NEUMATICO4_NRO_SERIE_VIEJO FROM gd_esquema.Maestra m
	WHERE m.NEUMATICO4_NRO_SERIE_NUEVO IS NOT NULL
	

	DECLARE c_box CURSOR FOR
	SELECT distinct m.AUTO_MODELO, m.AUTO_NUMERO, m.CODIGO_CARRERA, m.PARADA_BOX_TIEMPO, m.PARADA_BOX_VUELTA FROM gd_esquema.Maestra m
	WHERE m.PARADA_BOX_TIEMPO IS NOT NULL

	declare @auto_modelo nvarchar(255)
	declare @auto_numero int
	declare @codigo_carrera int
	declare @parada_box_tiempo decimal(18,2)
	declare @parada_box_vuelta decimal(18,0)

	

	BEGIN TRY
	BEGIN TRANSACTION
		OPEN c_box
		FETCH NEXT FROM c_box INTO @auto_modelo, @auto_numero, @codigo_carrera, @parada_box_tiempo, @parada_box_vuelta
		WHILE (@@FETCH_STATUS = 0)
		BEGIN

			declare @id_auto_carrera int
			declare @id_box int

			SET @id_auto_carrera = GDD_EXPRESS.fn_id_auto_carrera(@auto_modelo, @auto_numero, @codigo_carrera)

			INSERT INTO GDD_EXPRESS.Box_Parada (BOX_AUTO_CARRERA_ID, BOX_PARADA_TIEMPO, BOX_PARADA_VUELTA)
			VALUES (@id_auto_carrera, @parada_box_tiempo, @parada_box_vuelta)

			SET  @id_box = @@IDENTITY

			INSERT INTO GDD_EXPRESS.Cambio_Neumatico (BOX_PARADA_ID, NEUMATICO_NUEVO_ID, NEUMATICO_VIEJO_ID)
			SELECT @id_box, 
			GDD_EXPRESS.fn_id_neumatico(nc.NEUMATICO_NRO_SERIE_NUEVO), 
			GDD_EXPRESS.fn_id_neumatico(nc.NEUMATICO_NRO_SERIE_VIEJO) 
			FROM #t_neumatico_cambios nc
			WHERE nc.AUTO_MODELO = @auto_modelo AND nc.AUTO_NUMERO = @auto_numero AND nc.CODIGO_CARRERA = @codigo_carrera
			AND nc.PARADA_BOX_TIEMPO = @parada_box_tiempo

			FETCH NEXT FROM c_box INTO @auto_modelo, @auto_numero, @codigo_carrera, @parada_box_tiempo, @parada_box_vuelta

		END

		CLOSE c_box  
		DEALLOCATE c_box 


		COMMIT TRANSACTION	
		END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLA BOX PARADA';
        THROW 50001, @errorDescripcion, 1
	END CATCH
		
END
GO  


IF OBJECT_ID('GDD_EXPRESS.migracion_telemetria', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_telemetria
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_telemetria
AS
BEGIN

	BEGIN TRY
	BEGIN TRANSACTION
	


	COMMIT TRANSACTION	
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @errorDescripcion VARCHAR(255)
		SELECT @errorDescripcion = ERROR_MESSAGE() + ' ERROR MIGRANDO DATOS EN TABLA TELEMETRIA';
        THROW 50001, @errorDescripcion, 1
	END CATCH
		
END
GO  

	


	




EXECUTE GDD_EXPRESS.migracion_parametros;
EXECUTE GDD_EXPRESS.migracion_autos_escuderias;
EXECUTE GDD_EXPRESS.migracion_pilotos;
EXECUTE GDD_EXPRESS.migracion_carrera;
EXECUTE GDD_EXPRESS.migracion_auto_carrera;
EXECUTE GDD_EXPRESS.migracion_incidentes;
EXECUTE GDD_EXPRESS.migracion_box;
