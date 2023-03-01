--1. Visualizar el número de empleados de cada departamento. Utilizar GROUP BY para agrupar por departamento.
SELECT E.DEPT_NO , COUNT(E.EMP_NO) AS NUM_EMPLE
FROM EMPLE e 
GROUP BY E.DEPT_NO ;

--2. Visualizar los departamentos con más de 5 empleados. Utilizar GROUP BY para agrupar por departamento y HAVING para 
--   establecer la condición sobre los grupos.
SELECT E.DEPT_NO 
FROM EMPLE e 
GROUP BY E.DEPT_NO 
HAVING COUNT(E.EMP_NO)>5;

--3. Hallar la media de los salarios de cada departamento (utilizar la función avg y GROUP BY).
SELECT AVG(E.SALARIO) AS SALARIO_DEPT
FROM EMPLE e 
GROUP BY E.DEPT_NO;

--4. Visualizar el nombre de los empleados vendedores del departamento ʻVENTASʼ (Nombre del departamento=ʼVENTASʼ, 
--   oficio=ʼVENDEDORʼ).
SELECT E.APELLIDO
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
 AND D.DNOMBRE LIKE 'VENTAS'
 AND E.OFICIO LIKE 'VENDEDOR';

--5. Visualizar el número de vendedores del departamento ʻVENTASʼ (utilizar la función COUNT sobre la consulta anterior).
SELECT COUNT(E.APELLIDO) AS NUM_VENDEDORES
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
 AND D.DNOMBRE LIKE 'VENTAS'
 AND E.OFICIO LIKE 'VENDEDOR';

--6. Visualizar los oficios de los empleados del departamento ʻVENTASʼ.
SELECT DISTINCT E.OFICIO 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
 AND D.DNOMBRE LIKE 'VENTAS';

--7. A partir de la tabla EMPLE, visualizar el número de empleados de cada departamento cuyo oficio sea ʻEMPLEADOʼ 
--   (utilizar GROUP BY para agrupar por departamento. En la cláusula WHERE habrá que indicar que el oficio es ʻEMPLEADOʼ).
SELECT COUNT(E.EMP_NO) AS NUM_EMPLE
FROM EMPLE e 
WHERE E.OFICIO LIKE 'EMPLEADO'
GROUP BY E.DEPT_NO ;

--8. Visualizar el departamento con más empleados.
SELECT *
FROM (SELECT EMPLE.DEPT_NO 
		FROM EMPLE 
		GROUP BY EMPLE.DEPT_NO
		ORDER BY COUNT(EMPLE.EMP_NO) DESC)
WHERE ROWNUM=1;

--9. Mostrar los departamentos cuya suma de salarios sea mayor que la media de salarios de todos los empleados.
SELECT E.DEPT_NO , D.DNOMBRE 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
GROUP BY E.DEPT_NO, D.DNOMBRE  
HAVING SUM(E.SALARIO)>AVG(E.SALARIO);

--10. Para cada oficio obtener la suma de salarios.
SELECT E.OFICIO , SUM(E.SALARIO)
FROM EMPLE e 
GROUP BY E.OFICIO ;

--11. Visualizar la suma de salarios de cada oficio del departamento ʻVENTASʼ.
SELECT SUM(E.SALARIO), E.OFICIO 
FROM EMPLE e , DEPART d
WHERE E.DEPT_NO = D.DEPT_NO 
 AND D.DNOMBRE LIKE 'VENTAS'
GROUP BY E.OFICIO ;

--12. Visualizar el número de departamento que tenga más empleados cuyo oficio sea empleado.
SELECT *
FROM (SELECT DEPT_NO 
		FROM EMPLE e 
		WHERE OFICIO LIKE 'EMPLEADO'
		GROUP BY DEPT_NO
		ORDER BY COUNT(EMP_NO) DESC)
WHERE ROWNUM=1;

--13. Mostrar el número de oficios distintos de cada departamento.
SELECT COUNT(DISTINCT E.OFICIO) AS NUM_OFICIOS, E.DEPT_NO 
FROM EMPLE e 
GROUP BY E.DEPT_NO ;

--14. Mostrar los departamentos que tengan más de dos personas trabajando en la misma profesión.
SELECT E.DEPT_NO
FROM EMPLE e 
GROUP BY E.DEPT_NO, E.OFICIO  
HAVING COUNT(E.OFICIO)>2;

--15. Dada la tabla HERRAMIENTAS, visualizar por cada estantería la suma de las unidades.
SELECT H.ESTANTERIA , SUM(H.UNIDADES)
FROM HERRAMIENTAS h 
GROUP BY H.ESTANTERIA ;

--16. Visualizar la estantería con más unidades de la tabla HERRAMIENTAS.
SELECT *
FROM (SELECT H.ESTANTERIA , SUM(H.UNIDADES)
		FROM HERRAMIENTAS h 
		GROUP BY H.ESTANTERIA
		ORDER BY SUM(H.UNIDADES) DESC)
WHERE ROWNUM=1;

--17. Mostrar el número de médicos que pertenecen a cada hospital, ordenado por número descendente de hospital.
SELECT COUNT(M.DNI), M.COD_HOSPITAL  
FROM MEDICOS m 
GROUP BY M.COD_HOSPITAL 
ORDER BY M.COD_HOSPITAL  DESC;

--18. Realizar una consulta en la que se muestre por cada hospital el nombre de las especialidades que tiene.
SELECT DISTINCT H.NOMBRE , M.ESPECIALIDAD 
FROM HOSPITALES h, MEDICOS m 
WHERE H.COD_HOSPITAL = M.COD_HOSPITAL; 

--19. Realizar una consulta en la que aparezca por cada hospital y en cada especialidad el número de médicos 
--   (tendrás que partir de la consulta anterior y utilizar GROUP BY).
SELECT DISTINCT H.NOMBRE , M.ESPECIALIDAD, COUNT(M.DNI) AS NUM_MED 
FROM HOSPITALES h, MEDICOS m 
WHERE H.COD_HOSPITAL = M.COD_HOSPITAL
GROUP BY H.NOMBRE , M.ESPECIALIDAD;

--20. Obtener por cada hospital el número de empleados.
SELECT P.COD_HOSPITAL  , COUNT(P.DNI)
FROM PERSONAS p
GROUP BY P.COD_HOSPITAL ;

--21. Obtener por cada especialidad el número de trabajadores.
SELECT M.ESPECIALIDAD , COUNT(M.DNI)
FROM MEDICOS m
GROUP BY M.ESPECIALIDAD ;

--22. Visualizar la especialidad que tenga más médicos.
SELECT *
FROM (SELECT M.ESPECIALIDAD , COUNT(M.DNI)
		FROM MEDICOS m
		GROUP BY M.ESPECIALIDAD
		ORDER BY COUNT(M.DNI) DESC)
WHERE ROWNUM=1;

--23. ¿Cuál es el nombre del hospital que tiene mayor número de plazas?
SELECT *
FROM (SELECT H.NOMBRE
		FROM HOSPITALES h 
		 ORDER BY H.NUM_PLAZAS DESC )
WHERE ROWNUM=1;

--24. Visualizar las diferentes estanterías de la tabla HERRAMIENTAS ordenados descendentemente por estantería.
SELECT DISTINCT H.ESTANTERIA 
FROM HERRAMIENTAS h 
ORDER BY H.ESTANTERIA DESC;

--25. Averiguar cuántas unidades tiene cada estantería.
SELECT SUM(H.UNIDADES), H.ESTANTERIA 
FROM HERRAMIENTAS h 
GROUP BY H.ESTANTERIA ;

--26. Visualizar las estanterías que tengan más de 15 unidades
SELECT SUM(H.UNIDADES), H.ESTANTERIA 
FROM HERRAMIENTAS h 
GROUP BY H.ESTANTERIA 
HAVING SUM(H.UNIDADES)>15;

--27. ¿Cuál es la estantería que tiene más unidades?
SELECT *
FROM (SELECT H.ESTANTERIA, SUM(H.UNIDADES)
		FROM HERRAMIENTAS h 
		GROUP BY H.ESTANTERIA
		ORDER BY SUM(H.UNIDADES)DESC)
WHERE ROWNUM=1;

--28. A partir de las tablas EMPLE y DEPART mostrar los datos del departamento que no tiene ningún empleado.
SELECT D.*
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO (+) = D.DEPT_NO 
 AND E.DEPT_NO IS NULL;

--29. Mostrar el número de empleados de cada departamento. En la salida se debe mostrar también los departamentos que no 
--    tienen ningún empleado.
SELECT COUNT(E.EMP_NO) AS NUM_EMPLEADOS, D.DEPT_NO 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
GROUP BY D.DEPT_NO 
UNION 
SELECT COUNT(E.EMP_NO) AS NUM_EMPLEADOS, D.DEPT_NO 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO(+) = D.DEPT_NO 
 AND E.DEPT_NO IS NULL
GROUP BY D.DEPT_NO;

--30. Obtener la suma de salarios de cada departamento, mostrando las columnas DEPT_NO, SUMA DE SALARIOS y DNOMBRE. 
--    En el resultado también se deben mostrar los departamentos que no tienen asignados empleados.
SELECT SUM(E.SALARIO) AS SUMA_SALARIOS, D.DEPT_NO , D.DNOMBRE 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
GROUP BY D.DEPT_NO , D.DNOMBRE 
UNION 
SELECT SUM(E.SALARIO) AS SUMA_SALARIOS, D.DEPT_NO , D.DNOMBRE 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO(+) = D.DEPT_NO
 AND E.DEPT_NO IS NULL
GROUP BY D.DEPT_NO , D.DNOMBRE; 

--31. Utilizar la función IFNULL en la consulta anterior para que en el caso de que un departamento no tenga empleados, 
--    aparezca como suma de salarios el valor 0.
SELECT SUM(E.SALARIO) AS SUMA_SALARIOS, D.DEPT_NO , D.DNOMBRE 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO = D.DEPT_NO 
GROUP BY D.DEPT_NO , D.DNOMBRE 
UNION 
SELECT NVL(SUM(E.SALARIO),0) AS SUMA_SALARIOS, D.DEPT_NO , D.DNOMBRE 
FROM EMPLE e , DEPART d 
WHERE E.DEPT_NO(+) = D.DEPT_NO
 AND E.DEPT_NO IS NULL
GROUP BY D.DEPT_NO , D.DNOMBRE;

--32. Obtener el número de médicos que pertenecen a cada hospital, mostrando las columnas COD_HOSPITAL, NOMBRE y NÚMERO DE
--    MÉDICOS. En el resultado deben aparecer también los datos de los hospitales que no tienen médicos.
SELECT  H.COD_HOSPITAL, COUNT(M.DNI) AS NUM_MEDICOS, H.NOMBRE 
FROM MEDICOS m , HOSPITALES h 
WHERE M.COD_HOSPITAL = H.COD_HOSPITAL 
GROUP BY H.NOMBRE , H.COD_HOSPITAL
UNION 
SELECT H.COD_HOSPITAL, COUNT(M.DNI) AS NUM_MEDICOS, H.NOMBRE 
FROM MEDICOS m , HOSPITALES h 
WHERE M.COD_HOSPITAL(+) = H.COD_HOSPITAL
 AND M.COD_HOSPITAL IS NULL
GROUP BY H.NOMBRE , H.COD_HOSPITAL;
















