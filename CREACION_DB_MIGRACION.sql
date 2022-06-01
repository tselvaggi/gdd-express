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
PAIS_ID					int, --PK
PAIS_DETALLE				nvarchar(255),
PRIMARY KEY (PAIS_ID)
)

CREATE TABLE GDD_EXPRESS.Escuderia
(
ESCUDERIA_ID				int, --PK
ESCUDERIA_NOMBRE			nvarchar(255),
ESCUDERIA_PAIS_ID			int,
PRIMARY KEY(ESCUDERIA_ID),
FOREIGN KEY (ESCUDERIA_PAIS_ID) REFERENCES GDD_EXPRESS.Pais (PAIS_ID)
)


CREATE TABLE GDD_EXPRESS.Auto
(
AUTO_ID					int , --PK
AUTO_MODELO				nvarchar(255),
AUTO_ESCUDERIA_ID			int, --FK
PRIMARY KEY (AUTO_ID),
FOREIGN KEY (AUTO_ESCUDERIA_ID) REFERENCES GDD_EXPRESS.Escuderia (ESCUDERIA_ID)
)

CREATE TABLE GDD_EXPRESS.Piloto
(
PILOTO_ID				int, --PK
PILOTO_AUTO_ID				int, --FK
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

