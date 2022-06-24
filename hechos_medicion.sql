/*HECHO_MEDICION*/
/*Telemetria por auto, por vuelta, por circuito*/
select ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA
from GDD_EXPRESS.Auto_Carrera ac 
join GDD_EXPRESS.Carrera ca on ac.CARRERA_ID = ca.CARRERA_ID
join GDD_EXPRESS.Circuito ci on ca.CARRERA_CIRCUITO_ID = ci.CIRCUITO_ID
join GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
group by ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA

/*Telemetria de motor por auto, por circuito, por vuelta*/
select ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,telm.MOTOR_ID
from GDD_EXPRESS.Auto_Carrera ac 
join GDD_EXPRESS.Carrera ca on ac.CARRERA_ID = ca.CARRERA_ID
join GDD_EXPRESS.Circuito ci on ca.CARRERA_CIRCUITO_ID = ci.CIRCUITO_ID
join GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
join GDD_EXPRESS.Telemetria_Motor telm on telm.TELE_ID = tel.TELE_ID
group by ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,telm.MOTOR_ID

/*Telemetria de caja por auto, por circuito, por vuelta*/
select ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,telc.CAJA_ID
from GDD_EXPRESS.Auto_Carrera ac 
join GDD_EXPRESS.Carrera ca on ac.CARRERA_ID = ca.CARRERA_ID
join GDD_EXPRESS.Circuito ci on ca.CARRERA_CIRCUITO_ID = ci.CIRCUITO_ID
join GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
join GDD_EXPRESS.Telemetria_Caja_Cambios telc on telc.TELE_ID = tel.TELE_ID
group by ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,telc.CAJA_ID

/*Los id se repiten entre componenetes de distintos tipos, va a ser mejor generar primero la tabla de componentes como dimension y 
	despues poder cargar con los nuevos id las mediciones en la tabla de hechos
La tabla BI_COMPONENTES deberia tener para funcionar:
	id_componente(nuevo y unico) , id_tipo_componente(seria el original que se repetia)
Entonces la tabla de hechos_medicion haria referencia a ese id_componente para garantizar la unicidad de mediciones y se utilizaria el
id_tipo_componente para hacer la migracion de cada telemetria de los componentes
Probe y los id seguian si garantizar la unicidad (No me di cuenta asi que lo cambie por el numero de serie que si me lo garantizaba)
*/
CREATE TABLE GDD_EXPRESS.BI_Componente
(
COMPONENTE_ID				int IDENTITY(1,1), --PK
NRO_SERIE				nvarchar(255),
PRIMARY KEY (COMPONENTE_ID),
)

select * from GDD_EXPRESS.BI_Componente
--Cargo motores
insert into GDD_EXPRESS.BI_Componente (NRO_SERIE)
select distinct MOTOR_NRO_SERIE from GDD_EXPRESS.Motor where MOTOR_NRO_SERIE is not null
--Cargo cajas
insert into GDD_EXPRESS.BI_Componente (NRO_SERIE)
select distinct CAJA_NRO_SERIE from GDD_EXPRESS.Caja_Cambios where CAJA_NRO_SERIE is not null
--Cargo Frenos
insert into GDD_EXPRESS.BI_Componente (NRO_SERIE)
select distinct FRENO_NRO_SERIE from GDD_EXPRESS.Freno where FRENO_NRO_SERIE is not null
--Cargo Neumaticos
insert into GDD_EXPRESS.BI_Componente (NRO_SERIE)
select distinct NEUMATICO_NRO_SERIE from GDD_EXPRESS.Neumatico where NEUMATICO_NRO_SERIE is not null

--Controlo unicidad
select * from GDD_EXPRESS.BI_Componente JOIN GDD_EXPRESS.Motor on NRO_SERIE = MOTOR_NRO_SERIE
select * from GDD_EXPRESS.BI_Componente JOIN GDD_EXPRESS.Caja_Cambios on NRO_SERIE = CAJA_NRO_SERIE
select * from GDD_EXPRESS.BI_Componente JOIN GDD_EXPRESS.Neumatico on NRO_SERIE = NEUMATICO_NRO_SERIE
select * from GDD_EXPRESS.BI_Componente JOIN GDD_EXPRESS.Freno on NRO_SERIE = FRENO_NRO_SERIE

--Hago un select por tipo de telemetria para la carga en la tabla de hechos TO DO -- CALCULAR DESCAGSTE DE CADA TELEMETRIA
/*Telemetria de motor por auto, por circuito, por vuelta*/
select ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID
from GDD_EXPRESS.Auto_Carrera ac 
join GDD_EXPRESS.Carrera ca on ac.CARRERA_ID = ca.CARRERA_ID
join GDD_EXPRESS.Circuito ci on ca.CARRERA_CIRCUITO_ID = ci.CIRCUITO_ID
join GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
join GDD_EXPRESS.Telemetria_Motor telm on telm.TELE_ID = tel.TELE_ID
join GDD_EXPRESS.Motor mot on mot.MOTOR_ID=telm.MOTOR_ID
join GDD_EXPRESS.BI_Componente comp on comp.NRO_SERIE = mot.MOTOR_NRO_SERIE
group by ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID

/*Telemetria de caja de cambios por auto, por circuito, por vuelta*/
select ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID
from GDD_EXPRESS.Auto_Carrera ac 
join GDD_EXPRESS.Carrera ca on ac.CARRERA_ID = ca.CARRERA_ID
join GDD_EXPRESS.Circuito ci on ca.CARRERA_CIRCUITO_ID = ci.CIRCUITO_ID
join GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
join GDD_EXPRESS.Telemetria_Caja_Cambios telc on telc.TELE_ID = tel.TELE_ID
join GDD_EXPRESS.Caja_Cambios caj on caj.CAJA_ID=telc.CAJA_ID
join GDD_EXPRESS.BI_Componente comp on comp.NRO_SERIE = caj.CAJA_NRO_SERIE
group by ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID

/*Telemetria de neumaticos por auto, por circuito, por vuelta*/
select ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID
from GDD_EXPRESS.Auto_Carrera ac 
join GDD_EXPRESS.Carrera ca on ac.CARRERA_ID = ca.CARRERA_ID
join GDD_EXPRESS.Circuito ci on ca.CARRERA_CIRCUITO_ID = ci.CIRCUITO_ID
join GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
join GDD_EXPRESS.Telemetria_Neumatico teln on teln.TELE_ID = tel.TELE_ID
join GDD_EXPRESS.Neumatico neu on neu.NEUMATICO_ID=teln.NEUMATICO_ID
join GDD_EXPRESS.BI_Componente comp on comp.NRO_SERIE = neu.NEUMATICO_NRO_SERIE
group by ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID

/*Telemetria de frenos por auto, por circuito, por vuelta*/
select ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID
from GDD_EXPRESS.Auto_Carrera ac 
join GDD_EXPRESS.Carrera ca on ac.CARRERA_ID = ca.CARRERA_ID
join GDD_EXPRESS.Circuito ci on ca.CARRERA_CIRCUITO_ID = ci.CIRCUITO_ID
join GDD_EXPRESS.Telemetria tel on tel.TELE_AUTO_CARRERA_ID = ac.AUTO_CARRERA_ID
join GDD_EXPRESS.Telemetria_Freno telf on telf.TELE_ID = tel.TELE_ID
join GDD_EXPRESS.Freno fren on fren.FRENO_ID=telf.FRENO_ID
join GDD_EXPRESS.BI_Componente comp on comp.NRO_SERIE = fren.FRENO_NRO_SERIE
group by ac.AUTO_CARRERA_ID,ci.CIRCUITO_ID,tel.TELE_NUMERO_DE_VUELTA,comp.COMPONENTE_ID