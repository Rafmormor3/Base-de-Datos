#1 Averigua el DNI de todos los clientes.
SELECT DNI 
FROM CLIENTE ;

#2 Consulta todos los datos de todos los programas.
SELECT *
FROM PROGRAMA;

#3 Obtén un listado con los nombres de todos los programas.
SELECT NOMBRE 
FROM PROGRAMA;

#4 Genera una lista con todos los comercios.
SELECT NOMBRE 
FROM COMERCIO;

#5 Genera una lista de las ciudades con establecimientos donde se venden programas, sin que aparezcan valores duplicados (utiliza DISTINCT).
SELECT DISTINCT (COMERCIO.CIUDAD)
FROM PROGRAMA , DISTRIBUYE , COMERCIO 
WHERE PROGRAMA.CODIGO = DISTRIBUYE.CODIGO 
 AND DISTRIBUYE.CIF = COMERCIO.CIF; 

#6 Obtén una lista con los nombres de programas, sin que aparezcan valores duplicados (utiliza DISTINCT).
SELECT DISTINCT (NOMBRE)
FROM PROGRAMA ;

#7 Obtén el DNI más 4 de todos los clientes.
SELECT  DNI+4
FROM CLIENTE; 

#8 Haz un listado con los códigos de los programas multiplicados por 7.
SELECT CODIGO *7
FROM PROGRAMA ;

#9 ¿Cuáles son los programas cuyo código es inferior o igual a 10?
SELECT NOMBRE 
FROM PROGRAMA 
WHERE CODIGO<=10;

#10 ¿Cuál es el programa cuyo código es 11?
SELECT NOMBRE 
FROM PROGRAMA 
WHERE CODIGO = 11;

#11 ¿Qué fabricantes son de Estados Unidos?
SELECT NOMBRE 
FROM FABRICANTE 
WHERE PAIS LIKE 'Estados Unidos';

#12 ¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.
SELECT NOMBRE 
FROM FABRICANTE 
WHERE PAIS NOT IN ('España');

#13 Obtén un listado con los códigos de las distintas versiones de Windows.
SELECT CODIGO , VERSIONES 
FROM PROGRAMA 
WHERE NOMBRE LIKE 'Windows';

#14 ¿En qué ciudades comercializa programas El Corte Inglés?
SELECT CIUDAD 
FROM COMERCIO 
WHERE NOMBRE LIKE 'El Corte Ingles';

#15 ¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador IN.
SELECT NOMBRE 
FROM COMERCIO 
WHERE NOMBRE NOT IN ('El Corte Ingles');

#16 Genera una lista con los códigos de las distintas versiones de Windows y Access. Utilizar el operador IN.
SELECT CODIGO , VERSIONES 
FROM PROGRAMA 
WHERE NOMBRE IN ('Windows','Access');

#17 Obtén un listado que incluya los nombres de los clientes de edades comprendidas entre 10 y 25 y de los mayores de 50 años. 
#Da una solución con BETWEEN y otra sin BETWEEN.
SELECT NOMBRE 
FROM CLIENTE 
WHERE EDAD BETWEEN 10 AND 25
 OR EDAD > 50;

SELECT NOMBRE
FROM CLIENTE 
WHERE (EDAD>=10 AND EDAD<=25) 
 OR EDAD>=50;

#18 Saca un listado con los comercios de Sevilla y Madrid. No se admiten valores duplicados.
SELECT DISTINCT (NOMBRE)
FROM COMERCIO 
WHERE CIUDAD IN ('Sevilla', 'Madrid');

#19 ¿Qué clientes terminan su nombre en la letra “o”?
SELECT *
FROM CLIENTE 
WHERE NOMBRE LIKE '%o';

#20 ¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores de 30 años?
SELECT *
FROM CLIENTE 
WHERE NOMBRE LIKE '%o'
 AND EDAD >30;

#21 Obtén un listado en el que aparezcan los programas cuya versión finalice por una letra i, o cuyo nombre comience por una 
#A o por una W.
SELECT *
FROM PROGRAMA 
WHERE VERSIONES LIKE '%i'
 OR NOMBRE LIKE 'A%'
 OR NOMBRE LIKE 'W%';

#22 Obtén un listado en el que aparezcan los programas cuya versión finalice por una letra i, o cuyo 
#nombre comience por una A y termine por una S.
SELECT *
FROM PROGRAMA 
WHERE VERSIONES LIKE '%i'
 OR NOMBRE LIKE 'A%S';

#23 Obtén un listado en el que aparezcan los programas cuya versión finalice por una letra i, y cuyo nombre no comience por una A.
SELECT *
FROM PROGRAMA 
WHERE VERSIONES LIKE '%i'
 AND NOMBRE NOT LIKE 'A%';

#24 Obtén una lista de empresas por orden alfabético ascendente.
SELECT NOMBRE 
FROM FABRICANTE 
ORDER BY NOMBRE ASC;

#25 Genera un listado de empresas por orden alfabético descendente.
SELECT NOMBRE 
FROM FABRICANTE 
ORDER BY NOMBRE DESC;





