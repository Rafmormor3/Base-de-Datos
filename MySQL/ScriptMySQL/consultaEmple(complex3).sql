#1. Visualizar el número de empleados de cada departamento. Utilizar GROUP BY para agrupar por departamento.
SELECT COUNT(EMPLE.EMP_NO) AS NUMERO_EMPLE, DEPART.DNOMBRE 
FROM EMPLE , DEPART 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
GROUP BY DEPART.DNOMBRE; 

#2. Visualizar los departamentos con más de 5 empleados. Utilizar GROUP BY para agrupar por departamento y 
#   HAVING para establecer la condición sobre los grupos.
SELECT COUNT(EMPLE.EMP_NO) AS NUMERO_EMPLE, DEPART.DNOMBRE 
FROM EMPLE , DEPART 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
GROUP BY DEPART.DNOMBRE
HAVING COUNT(EMPLE.EMP_NO)>5;

#3. Hallar la media de los salarios de cada departamento (utilizar la función avg y GROUP BY).
SELECT AVG(EMPLE.SALARIO) AS SALARIO_MEDIO, DEPART.DNOMBRE  
FROM EMPLE, DEPART 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
GROUP BY DEPART.DNOMBRE ;

#4. Visualizar el nombre de los empleados vendedores del departamento ʻVENTASʼ (Nombre del departamento=ʼVENTASʼ, oficio=ʼVENDEDORʼ).
SELECT EMPLE.APELLIDO 
FROM EMPLE , DEPART 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
 AND EMPLE.OFICIO LIKE 'VENDEDOR'
 AND DEPART.DNOMBRE LIKE 'VENTAS';

#5. Visualizar el número de vendedores del departamento ʻVENTASʼ (utilizar la función COUNT sobre la consulta anterior).
SELECT COUNT(EMPLE.APELLIDO) AS NUMERO_VENDEDORES 
FROM EMPLE , DEPART 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
 AND EMPLE.OFICIO LIKE 'VENDEDOR'
 AND DEPART.DNOMBRE LIKE 'VENTAS';

#6. Visualizar los oficios de los empleados del departamento ʻVENTASʼ.
SELECT EMPLE.OFICIO 
FROM EMPLE, DEPART 
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
 AND DEPART.DNOMBRE LIKE 'VENTAS';

#7. A partir de la tabla EMPLE, visualizar el número de empleados de cadadepartamento cuyo oficio sea ʻEMPLEADOʼ 
#   (utilizar GROUP BY paraagrupar por departamento. En la cláusula WHERE habrá que indicar que eloficio es ʻEMPLEADOʼ).
SELECT COUNT(EMPLE.EMP_NO)
FROM EMPLE 
WHERE EMPLE.OFICIO LIKE 'EMPLEADO'
GROUP BY EMPLE.DEPT_NO ;

#8. Visualizar el departamento con más empleados.
SELECT COUNT(EMPLE.EMP_NO)
FROM EMPLE
GROUP BY EMPLE.DEPT_NO 
ORDER BY COUNT(EMPLE.EMP_NO) DESC LIMIT 1 ;

#9. Mostrar los departamentos cuya suma de salarios sea mayor que la media de salarios de todos los empleados.
SELECT DEPART.DNOMBRE 
FROM DEPART, EMPLE
WHERE DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DNOMBRE 
HAVING SUM(EMPLE.SALARIO)> AVG(EMPLE.SALARIO);

#10. Para cada oficio obtener la suma de salarios.
SELECT SUM(EMPLE.SALARIO), EMPLE.OFICIO 
FROM EMPLE
GROUP BY EMPLE.OFICIO ;

#11. Visualizar la suma de salarios de cada oficio del departamento ʻVENTASʼ.
SELECT SUM(EMPLE.SALARIO), EMPLE.OFICIO 
FROM EMPLE, DEPART
WHERE EMPLE.DEPT_NO = DEPART.DEPT_NO 
 AND DEPART.DNOMBRE  LIKE 'VENTAS'
GROUP BY EMPLE.OFICIO ;

#12. Visualizar el número de departamento que tenga más empleados cuyo oficio sea empleado.
SELECT DEPART.DEPT_NO 
FROM DEPART , EMPLE
WHERE DEPART.DEPT_NO = EMPLE.DEPT_NO 
 AND EMPLE.OFICIO LIKE 'EMPLEADO'
GROUP BY DEPART.DEPT_NO ;
ORDER BY COUNT(EMPLE.EMP_NO) DESC LIMIT 1;

#13. Mostrar el número de oficios distintos de cada departamento.
SELECT COUNT(DISTINCT EMPLE.OFICIO), EMPLE.DEPT_NO  
FROM EMPLE 
GROUP BY EMPLE.DEPT_NO ;

#14. Mostrar los departamentos que tengan más de dos personas trabajando en la misma profesión.
SELECT DEPART.DNOMBRE #, EMPLE.OFICIO , COUNT(EMPLE.OFICIO)
FROM DEPART, EMPLE
WHERE DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DNOMBRE , EMPLE.OFICIO 
HAVING COUNT(EMPLE.OFICIO)>2;

#15. Dada la tabla HERRAMIENTAS, visualizar por cada estantería la suma de las unidades.
SELECT HERRAMIENTAS.ESTANTERIA , SUM(HERRAMIENTAS.UNIDADES) AS SUMA_UNIDADES
FROM HERRAMIENTAS
GROUP BY HERRAMIENTAS.ESTANTERIA ;

#16. Visualizar la estantería con más unidades de la tabla HERRAMIENTAS
SELECT HERRAMIENTAS.ESTANTERIA , SUM(HERRAMIENTAS.UNIDADES) AS SUMA_UNIDADES
FROM HERRAMIENTAS
GROUP BY HERRAMIENTAS.ESTANTERIA 
ORDER BY SUMA_UNIDADES DESC LIMIT 1;

#17. Mostrar el número de médicos que pertenecen a cada hospital, ordenado por número descendente de hospital.
SELECT COUNT(MEDICOS.DNI)AS NUM_MEDICOS, HOSPITALES.COD_HOSPITAL 
FROM HOSPITALES, MEDICOS
WHERE HOSPITALES.COD_HOSPITAL = MEDICOS.COD_HOSPITAL 
GROUP BY HOSPITALES.COD_HOSPITAL 
ORDER BY HOSPITALES.COD_HOSPITAL DESC;

#18. Realizar una consulta en la que se muestre por cada hospital el nombre de las especialidades que tiene.
SELECT HOSPITALES.NOMBRE ,MEDICOS.ESPECIALIDAD 
FROM HOSPITALES, MEDICOS
WHERE HOSPITALES.COD_HOSPITAL = MEDICOS.COD_HOSPITAL
GROUP BY HOSPITALES.NOMBRE ,MEDICOS.ESPECIALIDAD
ORDER BY HOSPITALES.NOMBRE ;

#19. Realizar una consulta en la que aparezca por cada hospital y en cada especialidad el número de médicos (tendrás que partir de la consulta 
#    anterior y utilizar GROUP BY).
SELECT HOSPITALES.NOMBRE ,MEDICOS.ESPECIALIDAD, COUNT(MEDICOS.DNI) 
FROM HOSPITALES, MEDICOS
WHERE HOSPITALES.COD_HOSPITAL = MEDICOS.COD_HOSPITAL
GROUP BY HOSPITALES.NOMBRE ,MEDICOS.ESPECIALIDAD
ORDER BY HOSPITALES.NOMBRE ;

#20. Obtener por cada hospital el número de empleados.
SELECT PERSONAS.COD_HOSPITAL , COUNT(PERSONAS.DNI) AS NUM_EMPLEADOS
FROM PERSONAS
GROUP BY PERSONAS.COD_HOSPITAL ;

#21. Obtener por cada especialidad el número de trabajadores.
SELECT MEDICOS.ESPECIALIDAD , COUNT(MEDICOS.DNI)
FROM MEDICOS
GROUP BY MEDICOS.ESPECIALIDAD ;

#22. Visualizar la especialidad que tenga más médicos.
SELECT MEDICOS.ESPECIALIDAD , COUNT(MEDICOS.DNI)
FROM MEDICOS
GROUP BY MEDICOS.ESPECIALIDAD 
ORDER BY COUNT(MEDICOS.DNI) DESC LIMIT 2;

#23. ¿Cuál es el nombre del hospital que tiene mayor número de plazas?
SELECT HOSPITALES.NOMBRE  
FROM HOSPITALES 
ORDER BY HOSPITALES.NUM_PLAZAS DESC LIMIT 2;

#24. Visualizar las diferentes estanterías de la tabla HERRAMIENTAS ordenados descendentemente por estantería.
SELECT DISTINCT ESTANTERIA 
FROM HERRAMIENTAS
ORDER BY ESTANTERIA DESC;

#25. Averiguar cuántas unidades tiene cada estantería.
SELECT ESTANTERIA , SUM(UNIDADES)
FROM HERRAMIENTAS
GROUP BY ESTANTERIA;

#26. Visualizar las estanterías que tengan más de 15 unidades
SELECT ESTANTERIA , SUM(UNIDADES)
FROM HERRAMIENTAS
GROUP BY ESTANTERIA
HAVING SUM(UNIDADES) > 15;

#27. ¿Cuál es la estantería que tiene más unidades?
SELECT ESTANTERIA , SUM(UNIDADES)
FROM HERRAMIENTAS
GROUP BY ESTANTERIA
ORDER BY SUM(UNIDADES) DESC LIMIT 1;

#28. A partir de las tablas EMPLE y DEPART mostrar los datos del departamento que no tiene ningún empleado. 
SELECT DEPART.DEPT_NO, DEPART.DNOMBRE , DEPART.LOC, COUNT(EMPLE.EMP_NO) 
FROM DEPART LEFT JOIN EMPLE
ON DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO, DEPART.DNOMBRE , DEPART.LOC
HAVING COUNT(EMPLE.EMP_NO) = 0;

#29. Mostrar el número de empleados de cada departamento. En la salida se debe mostrar también los departamentos que no tienen ningún empleado.
SELECT DEPART.DEPT_NO , COUNT(EMPLE.EMP_NO) AS NUM_EMPLE
FROM DEPART LEFT JOIN EMPLE 
ON EMPLE.DEPT_NO = DEPART.DEPT_NO
GROUP BY DEPART.DEPT_NO;

#30. Obtener la suma de salarios de cada departamento, mostrando las columnas DEPT_NO, SUMA DE SALARIOS y DNOMBRE. En el resultado
#    también se deben mostrar los departamentos que no tienen asignados empleados.
SELECT DEPART.DEPT_NO , SUM(EMPLE.SALARIO) AS SUMA_SALARIO, DEPART.DNOMBRE  
FROM DEPART LEFT JOIN EMPLE
ON DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO ;

#31. Utilizar la función IFNULL en la consulta anterior para que en el caso de que un departamento no tenga empleados, aparezca como suma de
#    salarios el valor 0.
SELECT DEPART.DEPT_NO , IFNULL(SUM(EMPLE.SALARIO),0) AS SUMA_SALARIO, DEPART.DNOMBRE  
FROM DEPART LEFT JOIN EMPLE
ON DEPART.DEPT_NO = EMPLE.DEPT_NO 
GROUP BY DEPART.DEPT_NO ;

#32. Obtener el número de médicos que pertenecen a cada hospital, mostrando las columnas COD_HOSPITAL, NOMBRE y NÚMERO DEMÉDICOS. En el resultado 
#    deben aparecer también los datos de los hospitales que no tienen médicos.
SELECT HOSPITALES.COD_HOSPITAL ,HOSPITALES.NOMBRE , COUNT(MEDICOS.DNI)
FROM HOSPITALES LEFT JOIN MEDICOS
ON MEDICOS.COD_HOSPITAL = HOSPITALES.COD_HOSPITAL 
GROUP BY HOSPITALES.COD_HOSPITAL ,HOSPITALES.NOMBRE;








