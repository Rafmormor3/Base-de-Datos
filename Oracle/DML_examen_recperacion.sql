--1.Deberás registrarte en la base de datos de la Universidad como un nuevo alumno/a con tus
--datos personales y matricularte de la asignatura “Contabilidad”
INSERT INTO PERSONA(DNI) VALUES('48120019V');
INSERT INTO ALUMNO VALUES ('A1213', '48120019V');
INSERT INTO ALUMNO_ASIGNATURA VALUES ('A1213','160002',2);

SELECT IDASIGNATURA, NOMBRE FROM ASIGNATURA;
SELECT NUMEROMATRICULA FROM ALUMNO_ASIGNATURA aa ;

--2. El profesor de la asignatura “Contabilidad” se ha cambiado de Universidad por lo que es necesario darlo de baja de 
--   la base de datos y asignar la asignatura de “Contabilidad” a la nueva profesora que no se encuentra en el 
--   sistema cuyos datos son: DNI: 77222122K, NOMBRE Y APELLIDOS: MARTA LÓPEZ MARTOS, CIUDAD: SEVILLA, 
--   DIRECCIÓN: CALLE TARFIA, NÚMERO:9, TELÉFONO: 615891432, FECHA DE NACIMIENTO: 22 de Julio de 1981, SEXO: MUJER.

SELECT IDPROFESOR 
FROM ASIGNATURA a 
WHERE NOMBRE LIKE 'Contabilidad';

INSERT INTO PERSONA VALUES ('77222122K','MARTA','LÓPEZ MARTOS', 'SEVILLA', 'CALLE TARFIA', 9, '615891432', 
							TO_DATE('22/07/1981','dd/mm/yyyy'),0);

INSERT INTO PROFESOR VALUES ('P555','77222122K');

UPDATE ASIGNATURA SET IDPROFESOR = 'P555' WHERE NOMBRE  = 'Contabilidad';
SELECT * FROM ASIGNATURA a ;

DELETE FROM PROFESOR p WHERE IDPROFESOR LIKE 'P117';
SELECT * FROM PROFESOR p ;

--3. La universidad nos ha pedido que guardemos en una nueva tabla llamada ALUMNOS_MUYREPETIDORES que tendrá las 
--   siguientes columnas IDASIGNATURA, DNI, NOMBRE, APELLIDO Y TELÉFONO aquellos alumnos que se han matriculado tres o 
--   más veces de una asignatura. Deberás crear en primer lugar la tabla y luego utilizando una única sentencia guardar 
--   todos los datos solicitados
CREATE TABLE ALUMNOS_MUYREPETIDORES
(
	IDASIGNATURA VARCHAR2(6),
	DNI VARCHAR2(11),
	NOMBRE VARCHAR2(30),
	APELLIDO VARCHAR2(30),
	TELEFONO VARCHAR2(9),
	
	CONSTRAINT PK_AMR PRIMARY KEY (DNI)
);

--4. Sobre la tabla creada anteriormente ALUMNOS_MUYREPETIDORES nos han pedido que añadamos una nueva columna 
--   que se llamará “OBSERVACIONES”. Para los alumnos/as existentes en la tabla que residen en SEVILLA y cuyo número 
--   de teléfono contiene el 20 se rellenará la nueva columna con el texto “Se encuentra en seguimiento”;

UPDATE ALUMNOS_MUYREPETIDORES AR 
SET OBSERVACIONES = 'Se encuentra en seguimiento'
WHERE AR.DNI IN (SELECT P.DNI
				 FROM ALUMNO A, PERSONA P
				 WHERE A.DNI=P.DNI
				  AND P.CIUDAD LIKE 'SEVILLA'
				  AND P.TELEFONO LIKE '%20%');

--7. Crea la tabla JUEGODETRONOS con los campos, Inserta 3 filas distintas sobre la tabla JUEGO DE TRONOS.

CREATE TABLE JUEGODETRONOS 
(
	COD_PERSONAJE NUMBER(5),
	NOMBRE VARCHAR2(20),
	EDAD NUMBER(3),
	
	CONSTRAINT PK_JDT PRIMARY KEY (COD_PERSONAJE)
);

CREATE SEQUENCE SQ_NOMBRE START WITH 1 INCREMENT BY 1;
SELECT SQ_NOMBRE.NEXTVAL FROM DUAL;

INSERT INTO JUEGODETRONOS VALUES (SQ_NOMBRE.NEXTVAL, 'RAFA',40);
INSERT INTO JUEGODETRONOS VALUES (SQ_NOMBRE.NEXTVAL, 'MANOLO',70);
INSERT INTO JUEGODETRONOS VALUES (SQ_NOMBRE.NEXTVAL, 'ANTONIO',27);

SELECT * FROM JUEGODETRONOS ;

--8. Sobre la tabla JUEGODETRONOS deberás borrar todos los personajes cuya edad sea menos de 18 años y cuyo nombre empiece con la letra A en mayúscula.
DELETE FROM JUEGODETRONOS 
WHERE EDAD<18 
 AND NOMBRE LIKE 'A%';

--9. Para aquellas PERSONAS nacidas después del año 2000 se deberá actualizar su fecha de nacimiento con el valor 22/07/1981. Deberá
--   realizarse con una única instrucción.
UPDATE PERSONA 
SET FECHA_NACIMIENTO = TO_DATE('22/07/1981','dd/mm/yyyy') 
WHERE EXTRACT (YEAR FROM FECHA_NACIMIENTO)>2000;

SELECT * FROM PERSONA p ;

--10. Se ha detectado que en la tabla alumnos los nombres de los alumnos están en minúsculas. Se desea actualizar el nombre de cada alumno por el 
--    correspondiente convertido en MAYÚSCULA.

UPDATE PERSONA SET NOMBRE = UPPER(NOMBRE);
SELECT * FROM PERSONA p ;




















