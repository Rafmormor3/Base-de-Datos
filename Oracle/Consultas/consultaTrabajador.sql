--1. Nombre de los trabajadores cuya tarifa este entre 10 y 12 euros.
SELECT T.NOMBRE 
FROM TRABAJADOR t 
WHERE T.TARIFA BETWEEN 10 AND 12;

--2. ¿Cuáles son los oficios de los trabajadores asignados al edificio 435?
SELECT T.OFICIO 
FROM TRABAJADOR t , ASIGNACION a 
WHERE A.ID_T = T.ID_T 
 AND A.ID_E = 435;
 
--3. Indicar el nombre del trabajador y el de su supervisor.
SELECT T.NOMBRE , T2.NOMBRE AS SUPERVISOR
FROM TRABAJADOR t , TRABAJADOR t2 
WHERE T2.ID_T = T2.ID_SUPV 
 AND T.ID_SUPV = T2.ID_T ;

--4. Nombre de los trabajadores asignados a oficinas.
SELECT DISTINCT T.NOMBRE 
FROM TRABAJADOR t , ASIGNACION a , EDIFICIO e 
WHERE T.ID_T = A.ID_T 
 AND A.ID_E = E.ID_E 
 AND E.TIPO LIKE 'OFICINA';

--5. ¿Qué trabajadores reciben una tarifa por hora mayor que la de su supervisor?
SELECT DISTINCT T.NOMBRE  
FROM TRABAJADOR t , TRABAJADOR t2 
WHERE T2.ID_T = T2.ID_SUPV
 AND T.ID_SUPV = T2.ID_T 
 AND T.TARIFA > T2.TARIFA  ;

--6. ¿Cuál es el número total de días que se han dedicado a fontanería en el edificio 312?
SELECT SUM(A.NUM_DIAS) AS TOTAL_DIAS_FONTANERIA 
FROM ASIGNACION a , TRABAJADOR t 
WHERE A.ID_T = T.ID_T 
 AND T.OFICIO LIKE 'FONTANERO'
 AND A.ID_E =312;

--7. ¿Cuántos tipos de oficios diferentes hay?
SELECT COUNT(DISTINCT T.OFICIO) 
FROM TRABAJADOR t ;

--8. Para cada supervisor, ¿Cuál es la tarifa por hora más alta que se paga a un trabajador que informa a esesupervisor?
SELECT T2.ID_T , MAX(T.TARIFA) AS TARIFA_TRABAJADOR
FROM TRABAJADOR t , TRABAJADOR t2 
WHERE T2.ID_T = T2.ID_SUPV 
 AND T.ID_SUPV = T2.ID_T
GROUP BY T2.ID_T ;

--Si queremos el nombre:
SELECT T2.NOMBRE  , MAX(T.TARIFA) AS TARIFA_TRABAJADOR
FROM TRABAJADOR t , TRABAJADOR t2 
WHERE T2.ID_T = T2.ID_SUPV 
 AND T.ID_SUPV = T2.ID_T
GROUP BY T2.NOMBRE ;

--9. Para cada supervisor que supervisa a más de un trabajador, ¿cuál es la tarifa más alta que se para a un 
--   trabajador que informa a ese supervisor?
SELECT T2.ID_T , MAX(T.TARIFA) AS TARIFA_TRABAJADOR
FROM TRABAJADOR t , TRABAJADOR t2 
WHERE T2.ID_T = T2.ID_SUPV 
 AND T.ID_SUPV = T2.ID_T
GROUP BY T2.ID_T 
HAVING COUNT(T.ID_T)>1;

--10. Para cada tipo de edificio, ¿Cuál es el nivel de calidad medio de los edificios con categoría 1? Considérense 
--    sólo aquellos tipos de edificios que tienen un nivel de calidad máximo no mayor que 3.
SELECT E.TIPO  ,AVG(E.NIVEL_CALIDAD) AS NIVEL_CALIDAD_MEDIO
FROM EDIFICIO e 
WHERE E.CATEGORIA = 1
 AND E.NIVEL_CALIDAD < 3
GROUP BY E.TIPO ;

--11. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio?
SELECT T.NOMBRE 
FROM TRABAJADOR t 
WHERE (SELECT AVG(T.TARIFA) FROM TRABAJADOR t)>T.TARIFA ;

--12. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores que tienen   NI IDEA
--    su mismo oficio?
SELECT AVG(T.TARIFA)
FROM TRABAJADOR t 
GROUP BY T.OFICIO;

SELECT T.NOMBRE
FROM TRABAJADOR t 
WHERE T.TARIFA < ANY (SELECT AVG(T.TARIFA) FROM TRABAJADOR t GROUP BY T.OFICIO);

--13. ¿Qué trabajadores reciben una tarifa por hora menor que la del promedio de los trabajadores que dependen del mismo supervisor que él?
SELECT T.NOMBRE
FROM TRABAJADOR t 
WHERE T.TARIFA < (SELECT AVG(T2.TARIFA) FROM TRABAJADOR t2 WHERE T2.ID_SUPV = T.ID_SUPV );

--14. Seleccione el nombre de los electricistas asignados al edificio 435 y la fecha en la que empezaron a trabajar enél.
SELECT T.NOMBRE , A.FECHA_INICIO 
FROM TRABAJADOR t , ASIGNACION a 
WHERE T.ID_T = A.ID_T 
 AND T.OFICIO LIKE 'ELECTRICISTA'
 AND A.ID_E = 435;

--15. ¿Qué supervisores tienen trabajadores que tienen una tarifa por hora por encima de los 12 euros?
SELECT DISTINCT T2.NOMBRE AS SUPERVISOR
FROM TRABAJADOR t , TRABAJADOR t2 
WHERE T2.ID_T = T2.ID_SUPV 
 AND T.ID_SUPV = T2.ID_T
 AND T.TARIFA > 12;


