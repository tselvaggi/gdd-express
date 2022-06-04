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
SECTOR_TIPO_ID				int, --PK
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
CLIMA_ID				int, --PK
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
FOREIGN KEY (AUTO_ID) REFERENCES GDD_EXPRESS.Auto (AUTO_ID),
FOREIGN KEY (CARRERA_ID) REFERENCES GDD_EXPRESS.Carrera (CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Incidente_Tipo
(
INCIDENTE_TIPO_ID			int, --PK
INCIDENTE_TIPO_DETALLE			varchar(255),
PRIMARY KEY (INCIDENTE_TIPO_ID)
)

CREATE TABLE GDD_EXPRESS.Incidente_Bandera
(
INCIDENTE_BANDERA_ID			int, --PK
INCIDENTE_BANDERA_DETALLE		varchar(255),
PRIMARY KEY (INCIDENTE_BANDERA_ID)
)

CREATE TABLE GDD_EXPRESS.Incidente
(
INCIDENTE_ID				int, --PK
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
INCIDENTE_AUTO_CARRERA_ID		int, --PK, FK --ACID
INCIDENTE_NUMERO_VUELTA			decimal(18,0),
PRIMARY KEY(INCIDENTE_ID, INCIDENTE_AUTO_CARRERA_ID),
FOREIGN KEY (INCIDENTE_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Motor
(
MOTOR_ID				int, --PK
MOTOR_AUTO_CARRERA_ID			int, --FK
MOTOR_MODELO				nvarchar(255),
MOTOR_NRO_SERIE				nvarchar(255),
PRIMARY KEY (MOTOR_ID),
FOREIGN KEY (MOTOR_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Caja_Cambios
(
CAJA_ID					int, --PK
CAJA_AUTO_CARRERA_ID			int, --FK
CAJA_MODELO				nvarchar(50),
CAJA_NRO_SERIE				nvarchar(255),
PRIMARY KEY (CAJA_ID),
FOREIGN KEY (CAJA_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Posicion
(
POSICION_ID				int, --PK
POSICION_DETALLE			int,
PRIMARY KEY (POSICION_ID)
)

CREATE TABLE GDD_EXPRESS.Neumatico_Tipo
(
NEUMATICO_TIPO_ID			int, --PK
NEUMATICO_TIPO_DETALLE			varchar(255),
PRIMARY KEY (NEUMATICO_TIPO_ID)
)

CREATE TABLE GDD_EXPRESS.Neumatico
(
NEUMATICO_ID				int, --PK
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
FRENO_ID				int, --PK
FRENO_AUTO_CARRERA_ID			int, --FK
FRENO_NRO_SERIE				nvarchar(255),
FRENO_POSICION_ID			int,  --FK
PRIMARY KEY (FRENO_ID),
FOREIGN KEY (FRENO_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID),
FOREIGN KEY (FRENO_POSICION_ID) REFERENCES GDD_EXPRESS.Posicion (POSICION_ID)
)

CREATE TABLE GDD_EXPRESS.Box_Parada
(
BOX_PARADA_ID				int, --PK
BOX_PARADA_AUTO_CARRERA_ID		int, --FK
BOX_PARADA_VUELTA			decimal(18,0),
BOX_PARADA_TIEMPO			decimal(18,2),
PRIMARY KEY (BOX_PARADA_ID),
FOREIGN KEY (BOX_PARADA_AUTO_CARRERA_ID) REFERENCES GDD_EXPRESS.Auto_Carrera (AUTO_CARRERA_ID)
)

CREATE TABLE GDD_EXPRESS.Cambio_Neumatico
(
BOX_PARADA_ID				int, --PK, FK
NEUMATICO_ID				int, --PK, FK
PRIMARY KEY (BOX_PARADA_ID, NEUMATICO_ID),
FOREIGN KEY (BOX_PARADA_ID) REFERENCES GDD_EXPRESS.Box_Parada (BOX_PARADA_ID),
FOREIGN KEY (NEUMATICO_ID) REFERENCES GDD_EXPRESS.Neumatico (NEUMATICO_ID)
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
TELE_MOTOR_ID				int, --PK
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
TELE_CAJA_ID				int, --PK
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
TELE_FRENO_ID				int, --PK
TELE_ID					int, --FK
FRENO_TAMANIO_DISCO			decimal(18,2),
FRENO_TEMPERATURA			decimal(18,2),
FRENO_ID				int, --FK
PRIMARY KEY (TELE_FRENO_ID),
FOREIGN KEY (TELE_ID) REFERENCES GDD_EXPRESS.Telemetria (TELE_ID),
FOREIGN KEY (FRENO_ID) REFERENCES GDD_EXPRESS.Freno (FRENO_ID)
)

CREATE TABLE GDD_EXPRESS.Telemetria_Neumatico
(
TELE_NEUMATICO_ID			int, --PK
TELE_ID					int, --FK
NEUMATICO_PRESION			decimal(18,6),
NEUMATICO_PROFUNDIDAD			decimal(18,6),
NEUMATICO_TEMPERATURA			decimal(18,6),
NEUMATICO_ID				int, --FK
PRIMARY KEY (TELE_NEUMATICO_ID),
FOREIGN KEY (TELE_ID) REFERENCES GDD_EXPRESS.Telemetria (TELE_ID),
FOREIGN KEY (NEUMATICO_ID) REFERENCES GDD_EXPRESS.Neumatico (NEUMATICO_ID)
)	



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
			UNION
			SELECT distinct m.ESCUDERIA_NACIONALIDAD FROM gd_esquema.Maestra m
			where m.ESCUDERIA_NACIONALIDAD IS NOT NULL
			UNION
			SELECT distinct m.PILOTO_NACIONALIDAD FROM gd_esquema.Maestra m	
			where  m.PILOTO_NACIONALIDAD IS NOT NULL

			--TABLA TIPO SECTOR
			INSERT INTO GDD_EXPRESS.Sector_Tipo (SECTOR_TIPO_DETALLE)
			SELECT distinct m.SECTO_TIPO FROM gd_esquema.Maestra m
			where NOT m.SECTO_TIPO IS NULL 

			--TABLA CLIMA
			INSERT INTO GDD_EXPRESS.Clima (CLIMA_DETALLE)
			SELECT distinct m.CARRERA_CLIMA FROM gd_esquema.Maestra m
			where NOT m.CARRERA_CLIMA IS NULL 


		
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

			SET @id_pais = (select p.PAIS_ID from GDD_EXPRESS.Pais p WHERE p.PAIS_DETALLE = @escuderia_nacionalidad)

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

			SET @id_pais = (select p.PAIS_ID from GDD_EXPRESS.Pais p WHERE p.PAIS_DETALLE = @pilo_nacionalidad)

			SET @id_auto = (SELECT a.AUTO_ID FROM GDD_EXPRESS.Auto a
								WHERE a.AUTO_MODELO = @auto_modelo and a.AUTO_NUMERO = @auto_numero)


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

IF OBJECT_ID('GDD_EXPRESS.migracion_circuitos_sectores', 'P') IS NOT NULL
    DROP PROCEDURE GDD_EXPRESS.migracion_circuitos_sectores
GO

GO
CREATE PROCEDURE GDD_EXPRESS.migracion_circuitos_sectores
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

			SET @id_pais = (select p.PAIS_ID from GDD_EXPRESS.Pais p WHERE p.PAIS_DETALLE = @escuderia_nacionalidad)

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

EXECUTE GDD_EXPRESS.migracion_parametros;
EXECUTE GDD_EXPRESS.migracion_autos_escuderias;
EXECUTE GDD_EXPRESS.migracion_pilotos;

SELECT * FROM GDD_EXPRESS.Auto a
inner join GDD_EXPRESS.Escuderia e on e.[ESCUDERIA_ID] = a.AUTO_ESCUDERIA_ID 

SELECT * FROM GDD_EXPRESS.Piloto

SELECT * FROM GDD_EXPRESS.Pais