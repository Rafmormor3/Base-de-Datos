--1. Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el mensaje HOLA MUNDO.
CREATE OR REPLACE 
PROCEDURE ESCRIBE IS 
BEGIN 
	dbms_output.put_line('HOLA MUNDO');
END;

BEGIN
	ESCRIBE;
END;

--2. Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un parámetro de tipo VARCHAR2 que recibe un texto y 
--lo muestre por pantalla. La forma del procedimiento ser. la siguiente: ESCRIBE_MENSAJE (mensaje VARCHAR2)
CREATE OR REPLACE 
PROCEDURE ESCRIBE_MENSAJE(MENSAJE VARCHAR2) IS 
BEGIN
	dbms_output.put_line(MENSAJE);
END;

BEGIN
	ESCRIBE_MENSAJE('PACOMEX10');
END;


--3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de números desde un mínimo hasta un 
--máximo con un determinado paso. La forma del procedimiento ser. la siguiente: SERIE (minimo NUMBER, maximo NUMBER, paso NUMBER)
CREATE OR REPLACE PROCEDURE SERIE ( MINIMO NUMBER, MAXIMO NUMBER, PASO NUMBER) IS 
	NUM NUMBER;
BEGIN 
	NUM:=MINIMO;
	WHILE NUM < MAXIMO LOOP 
		dbms_output.put_line(NUM);
		NUM:=NUM+PASO;
	END LOOP;
	
END;

BEGIN
	SERIE(0,10,2);
END;

--4. Crea una función AZAR que reciba dos parámetros y genere un número al azar entre un mínimo y máximo indicado. 
--La forma de la función será la siguiente: AZAR (minimo NUMBER, maximo NUMBER) RETURN NUMBER
CREATE OR REPLACE 
FUNCTION  AZAR(MINIMO NUMBER, MAXIMO NUMBER)
RETURN NUMBER 
IS
BEGIN
	RETURN TRUNC(DBMS_RANDOM.VALUE(MINIMO,MAXIMO));
END;

SELECT AZAR(5,20) FROM DUAL;


--5. Crea una función NOTA que reciba un parámetro que será una nota numérica entre 0 y 10 y devuelva una cadena 
--de texto con la calificación (Suficiente, Bien, Notable, ...). La forma de la función será la siguiente: NOTA (nota NUMBER) RETURN VARCHAR2
CREATE OR REPLACE FUNCTION DUMMY.NOTA (NOTA NUMBER)
RETURN VARCHAR2
IS 
	N VARCHAR2(50);
BEGIN 
	IF NOTA>=0 AND NOTA<5 THEN 
		N:='INSUFICIENTE';
	ELSIF NOTA>=5 AND NOTA<6 THEN 
		N:='SUFICIENTE';
	ELSIF NOTA>=6 AND NOTA<7 THEN 
		N:='BIEN';
	ELSIF NOTA>=7 AND NOTA<9 THEN 
		N:='NOTABLE';
	ELSE
		N:='SOBRESALIENTE';
	END IF;
	RETURN N;
END NOTA;

SELECT NOTA(8) FROM DUAL;








