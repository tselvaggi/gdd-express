Select * From GDD_EXPRESS.Neumatico

SELECT t.TELE_AUTO_CARRERA_ID, max(tcc.CAJA_DESGASTE) - min(tcc.CAJA_DESGASTE) as desgasteCaja, 
max(tm.MOTOR_POTENCIA) - min(tm.MOTOR_POTENCIA) as desgasteMotor
FROM GDD_EXPRESS.Auto_Carrera ac
join GDD_EXPRESS.Telemetria t on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
join GDD_EXPRESS.Telemetria_Caja_Cambios tcc on tcc.TELE_ID = t.TELE_ID
join GDD_EXPRESS.Telemetria_Motor tm on tm.TELE_ID = t.TELE_ID
join GDD_EXPRESS.Carrera car on car.CARRERA_ID = ac.CARRERA_ID
WHERE t.TELE_POSICION <> 0
GROUP BY t.TELE_NUMERO_DE_VUELTA, t.TELE_AUTO_CARRERA_ID, car.CARRERA_CIRCUITO_ID

SELECT t.TELE_NUMERO_DE_VUELTA, t.TELE_AUTO_CARRERA_ID, tn.NEUMATICO_ID, 
MAX(tn.NEUMATICO_PROFUNDIDAD), MIN(tn.NEUMATICO_PROFUNDIDAD), MAX(tn.NEUMATICO_PROFUNDIDAD) - MIN(tn.NEUMATICO_PROFUNDIDAD) FROM GDD_EXPRESS.Telemetria_Neumatico tn
join GDD_EXPRESS.Telemetria t on t.TELE_ID = tn.TELE_ID
JOIN GDD_EXPRESS.Auto_Carrera ac ON ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID 
where t.TELE_POSICION <> 0 AND AC.AUTO_ID = 10 AND T.TELE_NUMERO_DE_VUELTA = 11
GROUP BY t.TELE_NUMERO_DE_VUELTA, t.TELE_AUTO_CARRERA_ID, tn.NEUMATICO_ID
order by 2,1

SELECT * FROM GDD_EXPRESS.Auto_Carrera WHERE AUTO_CARRERA_ID = 1

SELECT t.TELE_AUTO_CARRERA_ID, tf.FRENO_ID, MAX(tf.FRENO_GROSOR_PASTILLA) - MIN(tf.FRENO_GROSOR_PASTILLA) FROM GDD_EXPRESS.Telemetria_Freno tf
join GDD_EXPRESS.Telemetria t on t.TELE_ID = tf.TELE_ID
join GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
join GDD_EXPRESS.Carrera car on car.CARRERA_ID = ac.CARRERA_ID
WHERE t.TELE_POSICION <> 0
GROUP BY t.TELE_NUMERO_DE_VUELTA, t.TELE_AUTO_CARRERA_ID, tf.FRENO_ID, car.CARRERA_CIRCUITO_ID
order by 1, t.TELE_NUMERO_DE_VUELTA

SELECT * FROM GDD_EXPRESS.Cambio_Neumatico

SELECT * FROM GDD_EXPRESS.Neumatico WHERE NEUMATICO_ID = 2

ECX316357

DBO545060

SELECT * FROM gd_esquema.Maestra WHERE TELE_AUTO_NUMERO_VUELTA = 11 
AND (TELE_NEUMATICO1_NRO_SERIE = 'ECX316357' OR TELE_NEUMATICO2_NRO_SERIE = 'DBO545060' 
OR TELE_NEUMATICO3_NRO_SERIE = 'DBO545060' OR TELE_NEUMATICO4_NRO_SERIE = 'DBO545060')
AND CODIGO_CARRERA = 2


SELECT bp.BOX_AUTO_CARRERA_ID FROM GDD_EXPRESS.Cambio_Neumatico cn
join GDD_EXPRESS.Box_Parada bp on bp.BOX_PARADA_ID = cn.BOX_PARADA_ID

SELECT  TELE_AUTO_CARRERA_ID, TELE_NUMERO_DE_VUELTA, MAX(TELE_TIEMPO_DE_VUELTA) FROM GDD_EXPRESS.Telemetria
WHERE TELE_POSICION <> 0
GROUP BY TELE_AUTO_CARRERA_ID, TELE_NUMERO_DE_VUELTA
ORDER BY 2

SELECT * FROM GDD_EXPRESS.Telemetria
WHERE TELE_AUTO_CARRERA_ID = 90 AND TELE_NUMERO_DE_VUELTA = 3

SELECT * FROM GDD_EXPRESS.Incidente_Auto_Carrera iac
WHERE iac.INCIDENTE_AUTO_CARRERA_ID = 90

SELECT * FROM GDD_EXPRESS.Neumatico_Tipo


SELECT * FROM GDD_EXPRESS.Circuito 

SELECT * FROM GDD_EXPRESS.Sector

SELECT * FROM GDD_EXPRESS.Telemetria
WHERE TELE_AUTO_CARRERA_ID = 38
and TELE_NUMERO_DE_VUELTA IN (8,9,10,11)
ORDER BY TELE_AUTO_CARRERA_ID, TELE_NUMERO_DE_VUELTA

SELECT a.AUTO_ESCUDERIA_ID, YEAR(car.CARRERA_FECHA) as a�o, s.SECTOR_TIPO_ID, st.SECTOR_TIPO_DETALLE, count(*) as cantAccidentes FROM GDD_EXPRESS.Incidente i
JOIN GDD_EXPRESS.Incidente_Auto_Carrera iac on i.INCIDENTE_ID = iac.INCIDENTE_ID
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = iac.INCIDENTE_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera car on car.CARRERA_ID = ac.CARRERA_ID
JOIN GDD_EXPRESS.Auto a on a.AUTO_ID = ac.AUTO_ID
JOIN GDD_EXPRESS.Sector s ON s.SECTOR_ID = i.INCIDENTE_SECTOR_ID
JOIN GDD_EXPRESS.Circuito c ON c.CIRCUITO_ID = s.SECTOR_CIRCUITO_ID
JOIN GDD_EXPRESS.Sector_Tipo st ON st.SECTOR_TIPO_ID = s.SECTOR_TIPO_ID
GROUP BY a.AUTO_ESCUDERIA_ID, YEAR(car.CARRERA_FECHA), S.SECTOR_TIPO_ID, st.SECTOR_TIPO_DETALLE



SELECT MONTH('2022-12-11')

select DATEPART(, '2022-11-11')

SELECT * FROM GDD_EXPRESS.Box_Parada bp
WHERE  EXISTS (SELECT 1 FROM GDD_EXPRESS.Cambio_Neumatico cn WHERE bp.BOX_PARADA_ID = cn.BOX_PARADA_ID)

SELECT GETDATE()

SELECT a.AUTO_ESCUDERIA_ID, c.CARRERA_CIRCUITO_ID, c.CARRERA_FECHA, t.TELE_AUTO_CARRERA_ID, s.SECTOR_TIPO_ID, MAX(t.TELE_VELOCIDAD_AUTO) FROM GDD_EXPRESS.Telemetria t
JOIN GDD_EXPRESS.Sector s on s.SECTOR_ID = t.TELE_SECTOR_ID
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID
JOIN GDD_EXPRESS.Auto a on a.AUTO_ID = ac.AUTO_ID
GROUP BY t.TELE_AUTO_CARRERA_ID, s.SECTOR_TIPO_ID, a.AUTO_ESCUDERIA_ID, c.CARRERA_CIRCUITO_ID, c.CARRERA_FECHA

SELECT a.AUTO_ID, t.TELE_NUMERO_DE_VUELTA, a.AUTO_ESCUDERIA_ID, c.CARRERA_FECHA, c.CARRERA_CIRCUITO_ID, MAX(t.TELE_TIEMPO_DE_VUELTA), MAX(t.TELE_COMBUSTIBLE) - MIN(t.TELE_COMBUSTIBLE) FROM GDD_EXPRESS.Telemetria t
JOIN GDD_EXPRESS.Sector s on s.SECTOR_ID = t.TELE_SECTOR_ID
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID
JOIN GDD_EXPRESS.Auto a on a.AUTO_ID = ac.AUTO_ID
WHERE t.TELE_POSICION <> 0
GROUP BY t.TELE_AUTO_CARRERA_ID, a.AUTO_ID, a.AUTO_ESCUDERIA_ID, c.CARRERA_FECHA, c.CARRERA_CIRCUITO_ID, t.TELE_NUMERO_DE_VUELTA
order by 4

SELECT * from GDD_EXPRESS.carrera

SELECT * FROM GDD_EXPRESS.BI_Desgaste

SELECT a.AUTO_ID, c.CARRERA_CIRCUITO_ID, s.SECTOR_TIPO_ID, MAX(t.TELE_VELOCIDAD_AUTO) FROM GDD_EXPRESS.Telemetria t
JOIN GDD_EXPRESS.Sector s on s.SECTOR_ID = t.TELE_SECTOR_ID
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = t.TELE_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID
JOIN GDD_EXPRESS.Auto a on a.AUTO_ID = ac.AUTO_ID
WHERE t.TELE_POSICION <> 0
GROUP BY a.AUTO_ID, c.CARRERA_CIRCUITO_ID, s.SECTOR_TIPO_ID
ORDER BY 1, 2, 3


SELECT * FROM GDD_EXPRESS.Telemetria t
GROUP BY t.TELE_NUMERO_DE_VUELTA


SELECT a.AUTO_ID, a.AUTO_ESCUDERIA_ID, c.CARRERA_CIRCUITO_ID, c.CARRERA_FECHA, b.BOX_PARADA_TIEMPO FROM GDD_EXPRESS.Box_Parada b
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = b.BOX_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID
JOIN GDD_EXPRESS.Auto a on a.AUTO_ID = ac.AUTO_ID

SELECT a.AUTO_ID, a.AUTO_ESCUDERIA_ID, c.CARRERA_CIRCUITO_ID, i.INCIDENTE_TIPO_ID, i.INCIDENTE_SECTOR_ID FROM GDD_EXPRESS.Incidente i
JOIN GDD_EXPRESS.Incidente_Auto_Carrera iac on i.INCIDENTE_ID = iac.INCIDENTE_ID
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = iac.INCIDENTE_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID
JOIN GDD_EXPRESS.Auto a on a.AUTO_ID = ac.AUTO_ID
JOIN GDD_EXPRESS.Sector s on s.SECTOR_ID = i.INCIDENTE_SECTOR_ID

SELECT c.CARRERA_CIRCUITO_ID, YEAR(c.CARRERA_FECHA), count(distinct i.INCIDENTE_ID) FROM GDD_EXPRESS.Incidente i
JOIN GDD_EXPRESS.Incidente_Auto_Carrera iac on i.INCIDENTE_ID = iac.INCIDENTE_ID
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = iac.INCIDENTE_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID
GROUP BY c.CARRERA_CIRCUITO_ID, YEAR(c.CARRERA_FECHA)

SELECT a.AUTO_ESCUDERIA_ID, s.SECTOR_TIPO_ID, YEAR(c.CARRERA_FECHA), count(distinct i.INCIDENTE_ID) FROM GDD_EXPRESS.Incidente i
JOIN GDD_EXPRESS.Incidente_Auto_Carrera iac on i.INCIDENTE_ID = iac.INCIDENTE_ID
JOIN GDD_EXPRESS.Auto_Carrera ac on ac.AUTO_CARRERA_ID = iac.INCIDENTE_AUTO_CARRERA_ID
JOIN GDD_EXPRESS.Carrera c on c.CARRERA_ID = ac.CARRERA_ID
JOIN GDD_EXPRESS.Auto a on a.AUTO_ID = ac.AUTO_ID
JOIN GDD_EXPRESS.Sector s on s.SECTOR_ID = i.INCIDENTE_SECTOR_ID
GROUP BY a.AUTO_ESCUDERIA_ID, s.SECTOR_TIPO_ID, YEAR(c.CARRERA_FECHA)
ORDER BY 1,2

SELECT 1.0*1/2

SELECT * FROM gd_esquema.Maestra m