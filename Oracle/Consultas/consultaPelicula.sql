--1. Obtén las diferentes ciudades donde hay cines
SELECT DISTINCT C.CIUDAD_CINE 
FROM CINE c ;

--2. Obtener las películas con un presupuesto mayor de 2000 o cuya duración sea superior a 100.
SELECT P.TITULO_P 
FROM PELICULA p 
WHERE  P.PRESUPUESTO > 2000
 AND P.DURACION >100;

--3. Obtener las películas cuyo título (da igual el original o el español) contenga la cadena la sin
--   importar que esté en mayúsculas o minúsculas.
SELECT P.TITULO_P 
FROM PELICULA p 
WHERE (UPPER(P.TITULO_P) LIKE '%LA%') 
 OR (UPPER(P.TITULO_S) LIKE '%LA%');

--4. Obtener el nombre y la nacionalidad de los personajes que sean hombres ordenado por
--   nacionalidad y nombre.
SELECT P.NOMBRE_PERSONA , P.NACIONALIDAD_PERSONA 
FROM PERSONAJE p 
WHERE P.SEXO_PERSONA LIKE 'H'
ORDER BY P.NACIONALIDAD_PERSONA , P.NOMBRE_PERSONA ;

--5. Obtener las películas estrenadas en el mes de septiembre.
SELECT P.TITULO_P 
FROM PELICULA p, PROYECCION p2  
WHERE P.CIP = P2.CIP 
 AND EXTRACT(MONTH FROM P2.FECHA_ESTRENO)=9;

--6. Obtener las diferentes tareas que ha desempeñado alguna persona alguna vez.
SELECT T.TAREA 
FROM TRABAJO T, PERSONAJE p  
WHERE T.NOMBRE_PERSONA  = P.NOMBRE_PERSONA  ; 

--7. Obtener el numero de sala y el aforo de todas las salas de los cines que terminen en vocal.
SELECT S.SALA , S.AFORO , S.CINE 
FROM SALA s 
WHERE (S.CINE LIKE '%a')
 OR (S.CINE LIKE '%e')
 OR (S.CINE LIKE '%i')
 OR (S.CINE LIKE '%o')
 OR (S.CINE LIKE '%u');

--8. Obtener las distintas ciudades que tienen cines con alguna sala con aforo superior a 100
--   ordenadas por el nombre de la ciudad de la z a la a.
SELECT DISTINCT C.CIUDAD_CINE 
FROM CINE c , SALA s 
WHERE C.CINE = S.CINE 
 AND S.AFORO >100
ORDER BY C.CIUDAD_CINE DESC;

--9. Obtener los títulos (ambos) y la nacionalidad de las películas que hayan obtenido una
--   recaudación en alguna sala 10000 mayor que su presupuesto ordenadas de mayor a menor beneficio.
SELECT P.TITULO_P , P.TITULO_S , P.NACIONALIDAD  
FROM PELICULA p , PROYECCION p2 
WHERE P.CIP = P2.CIP 
 AND P2.RECAUDACION > 1000+P.PRESUPUESTO 
ORDER BY (P2.RECAUDACION-P.PRESUPUESTO) DESC;

--10. Obtener el nombre de los actores hombres que participen en la película Viaje al centro de la tierra.
SELECT T.NOMBRE_PERSONA 
FROM TRABAJO t , PELICULA p 
WHERE T.CIP = P.CIP 
 AND P.TITULO_P LIKE 'Viaje al centro de la tierra';

--11. Obtener el nombre del cine y el número de películas diferentes estrenadas por cada cine ordenadas por el número de películas 
--    ordenadas de mayor a menor.
SELECT P.CINE , COUNT(DISTINCT P.FECHA_ESTRENO) AS NUM_ESTRENOS
FROM PROYECCION p 
GROUP BY P.CINE
ORDER BY NUM_ESTRENOS ;

--12. Obtener el nombre y nacionalidad de las personas que hayan trabajado en alguna película de diferente nacionalidad a la suya.
SELECT P.NOMBRE_PERSONA , P.NACIONALIDAD_PERSONA
FROM PERSONAJE p , TRABAJO t , PELICULA p2 
WHERE P.NOMBRE_PERSONA = T.NOMBRE_PERSONA 
 AND T.CIP = P2.CIP 
 AND P.NACIONALIDAD_PERSONA != P2.NACIONALIDAD ;

--13. Obtener por cada cine, el nombre, las salas y el nombre de la película.
SELECT P.CINE , P.SALA , P2.TITULO_P 
FROM PROYECCION p , PELICULA p2 
WHERE P.CIP = P2.CIP ;

--14. Obtener la recaudación total de cada cine ordenada de mayor a menor recaudación total.
SELECT SUM(P.RECAUDACION) AS RECAUDACION_TOTAL
FROM PROYECCION p 
GROUP BY P.CINE 
ORDER BY RECAUDACION_TOTAL DESC ;

--15. Obtener aquellas personas que hayan realizado una tarea cuyo sexo sea diferente al suyo, teniendo en cuenta que para productor y 
--    director no hay un sexo definido.
SELECT P.*
FROM TAREA t , TRABAJO t2 , PERSONAJE p
WHERE T.TAREA =T2.TAREA 
 AND T2.NOMBRE_PERSONA = P.NOMBRE_PERSONA 
 AND T.SEXO_TAREA != P.SEXO_PERSONA ;

--16. Obtener el título, al año de producción, el presupuesto y la recaudación total de las películas que han sido proyectadas en algún 
--    cine de la ciudad de Córdoba.
SELECT P.TITULO_P , P.ANO_PRODUCCION , P.PRESUPUESTO , SUM(P2.RECAUDACION) AS RECAUDACION_TOTAL
FROM PELICULA p , PROYECCION p2, SALA s , CINE c  
WHERE P.CIP = P2.CIP
 AND P2.CINE  = S.CINE 
 AND S.CINE = C.CINE 
 AND C.CIUDAD_CINE  LIKE 'Cordoba'
GROUP BY P.TITULO_P , P.ANO_PRODUCCION , P.PRESUPUESTO;

--17. Obtener el título de las películas cuya recaudación por espectador (con 2 decimales) sea mayor de 700.
SELECT P.TITULO_P,ROUND(P2.RECAUDACION / P2.ESPECTADORES , 2) AS RECAUDACION_POR_ESPEC
FROM PELICULA p , PROYECCION p2 
WHERE P.CIP =P2.CIP 
 AND (P2.RECAUDACION / P2.ESPECTADORES )>700;

--18. Obtener el nombre de los actores que han participado en más de 2 películas.
SELECT P.NOMBRE_PERSONA 
FROM PERSONAJE p , TRABAJO t 
WHERE P.NOMBRE_PERSONA = T.NOMBRE_PERSONA 
GROUP BY P.NOMBRE_PERSONA 
HAVING COUNT(T.NOMBRE_PERSONA)>2;

