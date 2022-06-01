USE [GD1C2022]
GO

/****** Object:  Schema [gd_migracion]    Script Date: 30/5/2022 21:09:52 ******/
DROP SCHEMA [gd_migracion]
GO

/****** Object:  Schema [gd_migracion]    Script Date: 30/5/2022 21:09:52 ******/
CREATE SCHEMA [gd_migracion]
GO

-- PARAMETROS

CREATE TABLE gd_migracion.Pais
	(
	PAIS_ID int NULL, --PK
	PAIS_DETALLE nvarchar(255) NULL
	)

CREATE TABLE gd_migracion.Clima
	(
	CLIMA_ID int NULL, --PK
	CLIMA_DETALLE nvarchar(100)
	)

CREATE TABLE gd_migracion.Incidente_Tipo
	(
	INCIDENTE_TIPO_ID int NULL, --PK
	INCIDENTE_TIPO_DETALLE varchar(255) NULL
	)

CREATE TABLE gd_migracion.Incidente_Bandera
	(
	INCIDENTE_BANDERA_ID int NULL, --PK
	INCIDENTE_BANDERA_DETALLE varchar(255) NULL
	)

CREATE TABLE gd_migracion.Posicion
	(
	POSICION_ID int NULL, --PK
	POSICION_DETALLE int NULL
	)

CREATE TABLE gd_migracion.Tipo_Neumatico
	(
	TIPO_NEUMATICO_ID int NULL, --PK
	TIPO_NEUMATICO_DETALLE varchar(255) NULL
	)

CREATE TABLE gd_migracion.Sector_Tipo
	(
	TIPO_SECTOR_ID int NULL, --PK
	TIPO_SECTOR_DETALLE nvarchar(255) NULL
	)

-- PILOTO, ESCUDERIA Y AUTO

CREATE TABLE gd_migracion.Piloto
	(
	PILOTO_ID int NULL, --PK
	AUTO_ID int NULL, --FK
	PILOTO_NOMBRE nvarchar(50) NULL,
	PILOTO_APELLIDO nvarchar(50) NULL,
	PILOTO_NACIONALIDAD int NULL,
	PILOTO_FECHA_NACIMIENTO date NULL
	)

CREATE TABLE gd_migracion.Escuderia
	(
	ESCUDERIA_ID int NULL, --PK
	ESCUDERIA_NOMBRE nvarchar(255) NULL,
	ESCUDERIA_NACIONALIDAD int NULL
	)


CREATE TABLE gd_migracion.Auto
	(
	AUTO_ID int NULL, --PK
	AUTO_MODELO nvarchar(255) NULL,
	AUTO_ESCUDERIA_ID int NULL --FK
	)

-- PARTES AUTO

CREATE TABLE gd_migracion.Motor
	(
	MOTOR_ID int NULL, --PK
	MOTOR_AUTO_ID int NULL, --FK
	MOTOR_CARRERA_ID int NULL, --FK
	MOTOR_MODELO nvarchar(255),
	MOTOR_NRO_SERIE nvarchar(255)
	)


CREATE TABLE gd_migracion.Caja_Cambios
	(
	CAJA_ID int NULL, --PK
	CAJA_AUTO_ID int NULL, --FK
	CAJA_CARRERA_ID int NULL, --FK
	CAJA_MODELO nvarchar(50) NULL,
	CAJA_NRO_SERIE nvarchar(255) NULL
	)

CREATE TABLE gd_migracion.Freno
	(
	FRENO_ID int NULL, --PK
	FRENO_AUTO_ID int NULL, --FK
	FERNO_CARRERA_ID int NULL, --FK
	FRENO_NRO_SERIE nvarchar(255) NULL,
	FRENO_POSICION_ID int NULL --FK
	)

CREATE TABLE gd_migracion.Neumatico
	(
	NEUMATICO_ID int NULL, --PK
	NEUMATICO_AUTO_ID int NULL, --FK
	NEUMATICO_CARRERA_ID int NULL, --FK
	NEUMATICO_NRO_SERIE nvarchar(255) NULL,
	NEUMATICO_TIPO int NULL,
	NEUMATICO_POSICION_ID int NULL --FK
	)

-- CARRERA

CREATE TABLE gd_migracion.Auto_Carrera
	(
	AUTO_ID int NULL, --PK, FK
	CARRERA_ID int NULL --PK, FK
	)

CREATE TABLE gd_migracion.Carrera
	(
	CARRERA_ID int NULL, --PK
	CARRERA_FECHA date NULL,
	CARRERA_CLIMA_ID int NULL, --FK
	CARRERA_CANT_VUELTAS int NULL,
	CARRERA_CIRCUITO_ID int NULL --FK
	)

CREATE TABLE gd_migracion.Circuito
	(
	CIRCUITO_ID int NULL, --PK
	CIRCUITO_NOMBRE nvarchar(255) NULL,
	CIRCUITO_PAIS int NULL --FK
	)

CREATE TABLE gd_migracion.Sector
	(
	SECTOR_ID int NULL, --PK
	SECTOR_DISTANCIA decimal(18,2) NULL, 
	SECTOR_TIPO_ID int NULL, --FK
	SECTOR_CIRCUITO_ID int NULL --FK
	)

-- PARADA BOX

CREATE TABLE gd_migracion.Box_Parada
	(
	BOX_PARADA_ID int NULL, --PK
	BOX_PARADA_AUTO_ID int NULL, --FK
	BOX_PARADA_CARRERA_ID int NULL, --FK
	BOX_PARADA_VUELTA decimal(18,0) NULL,
	BOX_PARADA_TIEMPO decimal(18,2) NULL
	)

CREATE TABLE gd_migracion.Cambio_Neumatico
	(
	CAMBIO_NEUMATICO_ID int NULL, --PK
	BOX_PARADA_ID int NULL, --FK
	NEUMATICO_ID int NULL --FK
	)

-- INCIDENTES

CREATE TABLE gd_migracion.Incidente
	(
	INCIDENTE_ID int NULL, --PK
	INCIDENTE_BANDERA_ID int NULL, --FK
	INCIDENTE_TIPO_ID int NULL, --FK
	INCIDENTE_TIEMPO decimal(18,n) NULL,
	INCIDENTE_SECTOR_ID int NULL --FK
	)

CREATE TABLE gd_migracion.Incidente_Auto_Carrera
	(
	INCIDENTE_ID int NULL, --PK, FK
	INCIDENTE_AUTO_ID int NULL, --PK, FK
	INCIDENTE_CARRERA_ID int NULL, --PK, FK
	INCIDENTE_NUMERO_VUELTA decimal(18,0) NULL
	)

-- TELEMETRIA



CREATE TABLE gd_migracion.Telemetria
	(
	TELE_ID int NULL, --PK
	TELE_AUTO_ID int NULL, --FK
	TELE_CARRERA_ID int NULL, --FK
	TELE_SECTOR_ID int NULL, --FK
	TELE_NUMERO_DE_VUELTA decimal(18,0) NULL,
	TELE_DISTANCIA_VUELTA decimal(18,2) NULL,
	TELE_TIEMPO_DE_VUELTA decimal(18,10) NULL,
	TELE_POSICION decimal(18,0) NULL,
	TELE_VELOCIDAD_AUTO decimal(18,2) NULL,
	TELE_COMBUSTIBLE decimal(18,2) NULL
	)

CREATE TABLE gd_migracion.Telemetria_Motor
	(
	TELE_MOTOR_ID int NULL, --PK
	TELE_ID int NULL, --FK
	MOTOR_POTENCIA decimal(18.2) NULL,
	MOTOR_RPM decimal(18.2) NULL,
	MOTOR_TEMP_ACEITE decimal(18.2) NULL,
	MOTOR_TEMP_AGUA decimal(18.2) NULL,
	MOTOR_ID int NULL --FK
	)

CREATE TABLE gd_migracion.Telemetria_Caja_Cambios
	(
	TELE_CAJA_CAMBIOS_ID int NULL, --PK
	TELE_ID int NULL, --FK
	CAJA_CAMBIOS_TEMP_ACEITE decimal(18,2) NULL,
	CAJA_CAMBIOS_RPM decimal(18,2) NULL,
	CAJA_CAMBIOS_DESGASTE decimal(18,2) NULL,
	CAJA_CAMBIOS_ID int NULL --FK
	)

CREATE TABLE gd_migracion.Telemetria_Freno
	(
	TELE_FRENO_ID int NULL, --PK
	TELE_ID int NULL, --FK
	FRENO_TAMANIO_DISCO decimal(18,2) NULL,
	FRENO_TEMPERATURA decimal(18,2) NULL,
	FRENO_ID int NULL --FK
	)

CREATE TABLE gd_migracion.Telemetria_Neumatico
	(
	TELE_NEUMATICO_ID int NULL, --PK
	TELE_ID int NULL, --FK
	NEUMATICO_PRESION decimal(18,6) NULL,
	NEUMATICO_PROFUNDIDAD decimal(18,6) NULL,
	NEUMATICO_TEMPERATURA decimal(18,6) NULL,
	NEUMATICO_ID int --FK
	)	





