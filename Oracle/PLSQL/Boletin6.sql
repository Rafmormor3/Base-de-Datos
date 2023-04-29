--1. Realizar un procedure que se llame insertar_alumno, que recibirá como parámetro el nombre y apellido de 
--una persona, e inserte de forma automática esa persona como alumno.
CREATE OR REPLACE PROCEDURE UNIVERSIDAD.INSERTAR_ALUMNOS(NOM VARCHAR2, APELL VARCHAR2) IS 

DNI_PERSONA VARCHAR2(50);
CODIGO VARCHAR2(50);
N VARCHAR2(50);
A VARCHAR2(50);

CONT_DNI NUMBER;
BEGIN
	SELECT DNI
	INTO DNI_PERSONA
	FROM PERSONA
	WHERE PERSONA.NOMBRE LIKE NOM 
	AND PERSONA.APELLIDO LIKE APELL;

	SELECT SUBSTR(NOMBRE,0,3)
	INTO N 
	FROM PERSONA 
	WHERE NOMBRE LIKE NOM;

	SELECT SUBSTR(APELLIDO,0,3)
	INTO A
	FROM PERSONA 
	WHERE APELLIDO  LIKE APELL;

	CODIGO:= CONCAT(N,A);

	INSERT INTO ALUMNO(IDALUMNO, DNI) VALUES (CODIGO, DNI_PERSONA);
	dbms_output.put_line('hecho');

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('NO EXISTE');
	
	SELECT COUNT(DNI)
	INTO CONT_DNI
	FROM PERSONA
	WHERE DNI LIKE DNI_PERSONA;

	IF CONT_DNI<1 THEN
	RAISE_APPLICATION_ERROR(-20003,'NO EXISTE');
	END IF;

END;

BEGIN
	INSERTAR_ALUMNOS('rosario','Diaz');
END;


--2.Realizar una función que reciba como parámetro el nombre y el apellido de una persona, también debe 
--recibir un parámetro que podrá ser un 1 (en ese caso debe insertarlo como un alumno) o un 2 (debe insertarlo 
--como profesor), y un parámetro de entrada salida en el que deberá devolver el código del profesor o alumno 
--insertado. La función deberá devolver un 1 si se ha podido realizar la inserción, y un cero si ha ocurrido 
--algún error.

CREATE OR REPLACE FUNCTION INSERTARPERSONA (NOM VARCHAR2, APELL VARCHAR2, BANDERA NUMBER, COD VARCHAR2) RETURN VARCHAR2 IS 

DNI_PERSONA VARCHAR2(50);
CODIGO VARCHAR2(50);
N VARCHAR2(50);
A VARCHAR2(50);

CONT_DNI NUMBER;

BEGIN
	
	SELECT DNI
	INTO DNI_PERSONA
	FROM PERSONA
	WHERE PERSONA.NOMBRE LIKE NOM 
	AND PERSONA.APELLIDO LIKE APELL;
	
	CODIGO:=COD;

	IF BANDERA = 1 THEN
		INSERT INTO ALUMNO(IDALUMNO, DNI) VALUES (CODIGO, DNI_PERSONA);
		dbms_output.put_line('hecho');
	
	ELSIF BANDERA=2 THEN
		INSERT INTO PROFESOR(IDPROFESOR, DNI) VALUES (CODIGO, DNI_PERSONA);
		dbms_output.put_line('hecho');
	END IF;

	RETURN CODIGO;
		
END;

DECLARE
RES VARCHAR2(50);
BEGIN
	RES:=INSERTARPERSONA('LUIS','Jimenez',2,'FLAM');
	dbms_output.put_line(RES);
END;












