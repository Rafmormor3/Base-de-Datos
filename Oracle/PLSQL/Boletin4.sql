--5.6.1. Desarrolla el paquete ARITMETICA cuyo código fuente viene en este tema.
--Crea un archivo para la especi(cación y otro para el cuerpo. Realiza varias pruebas
--para comprobar que las llamadas a funciones y procedimiento funcionan correctamente.
CREATE OR REPLACE PACKAGE ARITMETICA IS
  version NUMBER := 1.0;

 	FUNCTION SUMA(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION RESTA(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION MULTIPLICACION(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION DIVISION(a NUMBER, b NUMBER) RETURN NUMBER;
 
END ARITMETICA;

CREATE OR REPLACE PACKAGE BODY ARITMETICA IS 

	FUNCTION SUMA(A NUMBER, B NUMBER) RETURN NUMBER IS 
	BEGIN 
		RETURN(A+B);
	END;

	FUNCTION RESTA(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A-B);
	END;

	FUNCTION MULTIPLICACION(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A*B);
	END;

	FUNCTION DIVISION(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A/B);
	END;


END ARITMETICA;

SELECT ARITMETICA.SUMA(4,5) FROM DUAL;
SELECT ARITMETICA.RESTA(7,3) FROM DUAL;
SELECT ARITMETICA.MULTIPLICACION(6,6) FROM DUAL;
SELECT ARITMETICA.DIVISION(45, 5) FROM DUAL; 

--5.6.2. Al paquete anterior añade una función llamada RESTO que reciba dos
--parámetros, el dividendo y el divisor, y devuelva el resto de la división.
CREATE OR REPLACE PACKAGE ARITMETICA IS
  version NUMBER := 1.0;

 	FUNCTION SUMA(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION RESTA(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION MULTIPLICACION(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION DIVISION(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION RESTO(a NUMBER, b NUMBER) RETURN NUMBER;	
 
END ARITMETICA;

CREATE OR REPLACE PACKAGE BODY ARITMETICA IS 

	FUNCTION SUMA(A NUMBER, B NUMBER) RETURN NUMBER IS 
	BEGIN 
		RETURN(A+B);
	END;

	FUNCTION RESTA(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A-B);
	END;

	FUNCTION MULTIPLICACION(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A*B);
	END;

	FUNCTION DIVISION(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A/B);
	END;

	FUNCTION RESTO(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(MOD(A,B));
	END;

END ARITMETICA;

SELECT ARITMETICA.RESTO(4,3) FROM DUAL;

--5.6.3. Al paquete anterior añade un procedimiento sin parámetros llamado AYUDA
--que muestre un mensaje por pantalla de los procedimientos y funciones disponibles
--en el paquete, su utilidad y forma de uso.

CREATE OR REPLACE PACKAGE ARITMETICA IS
  version NUMBER := 1.0;

 	FUNCTION SUMA(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION RESTA(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION MULTIPLICACION(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION DIVISION(a NUMBER, b NUMBER) RETURN NUMBER;
 	FUNCTION RESTO(a NUMBER, b NUMBER) RETURN NUMBER;	
 	PROCEDURE AYUDA;
 
END ARITMETICA;

CREATE OR REPLACE PACKAGE BODY ARITMETICA IS 

	FUNCTION SUMA(A NUMBER, B NUMBER) RETURN NUMBER IS 
	BEGIN 
		RETURN(A+B);
	END;

	FUNCTION RESTA(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A-B);
	END;

	FUNCTION MULTIPLICACION(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A*B);
	END;

	FUNCTION DIVISION(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(A/B);
	END;

	FUNCTION RESTO(A NUMBER, B NUMBER) RETURN NUMBER IS
	BEGIN
		RETURN(MOD(A,B));
	END;

	PROCEDURE AYUDA IS
	BEGIN
		dbms_output.put_line('SUMA: DEVUELVE LA SUMA ENTRE EL VALOR A Y EL VALOR B');
		dbms_output.put_line('RESTA: DEVUELVE LA DIFERENCIA ENTRE EL VALOR A Y EL VALOR B');
		dbms_output.put_line('MULTIPLICACION: DEVUELVE EL PRODUCTO ENTRE EL VALOR A Y EL VALOR B');
		dbms_output.put_line('DIVISION: DEVUELVE EL RESULTADO DE LA DIVISION ENTRE VALOR A Y EL VALOR B');
		dbms_output.put_line('RESTO: DEVUELVE EL RESTO DE LA DIVISION ENTRE EL VALOR A Y EL VALOR B');
	END;

END ARITMETICA;

BEGIN
	ARITMETICA.AYUDA;
END;

--5.6.4. Desarrolla el paquete GESTION. En un principio tendremos los
--procedimientos para gestionar los departamentos. Dado el archivo de
--especi(cación mostrado más abajo crea el archivo para el cuerpo. Realiza varias
--pruebas para comprobar que las llamadas a funciones y procedimientos funcionan correctamente.

ALTER TABLE DEPT ADD PRESUPUESTO NUMBER(10);

CREATE OR REPLACE PACKAGE GESTION IS

	PROCEDURE CREAR_DEP (nombre VARCHAR2, presupuesto NUMBER);
	FUNCTION NUM_DEP (nombre VARCHAR2) RETURN NUMBER;
	PROCEDURE MOSTRAR_DEP (numero NUMBER);
	PROCEDURE BORRAR_DEP (numero NUMBER);
	PROCEDURE MODIFICAR_DEP (numero NUMBER, presupuesto NUMBER);

END GESTION;

CREATE OR REPLACE PACKAGE BODY GESTION IS

	PROCEDURE CREAR_DEP(NOMBRE VARCHAR2, PRESUPUESTO NUMBER)IS
	BEGIN 
		INSERT INTO DEPT(DNAME, PRESUPUESTO)
	END;
	
	FUNCTION NUM_DEP(NOMBRE VARCHAR2) RETURN NUMBER IS
	TEMPORAL DEPT.DEPTNO%TYPE;
	BEGIN
		SELECT ENAME INTO TEMPORAL FROM DEPT WHERE DNAME = NOMBRE;
		RETURN TEMPORAL;

	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('EMPLEADO NO ENCONTRADO');
	END;

	PROCEDURE MOSTRAR_DEP (NUMERO NUMBER) IS
	FILA_DEP DEPT%ROWTYPE;
	BEGIN
		SELECT * INTO FILA_DEP FROM DEPT WHERE DEPTNO =NUMERO;
		DBMS_OUTPUT.PUT_LINE(FILA_DEP.DNAME || ', ' || FILA_DEP.DEPTNO ||', '|| FILA_DEP.LOC);
		
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('DEPARTAMENTO NO ENCONTRADO');
	END;

	PROCEDURE BORRAR_DEP(NUM NUMBER) IS
	BEGIN
		DELETE FROM DEPT WHERE DEPT.DEPTNO = NUM;
	
	IF SQL%NOTFOUND THEN
		RAISE_APPLICATION_ERROR(-20005, 'NO SE PUDO BORRAR');
	ELSIF SQL%ROWCOUNT > 5 THEN
		RAISE_APPLICATION_ERROR(-20006, 'BORADAS MUCHAS FILAS');
	END IF;

		dbms_output.put_line('BORRADO');
	END;

	PROCEDURE MODIFICAR(NUMERO NUMBER, PRESUP NUMBER) IS
	BEGIN
		UPDATE DEPT SET DEPT.PRESUPUESTO=PRESUP WHERE DEPT.DEPTNO = NUMERO;
	
	IF SQL%NOTFOUND THEN
		RAISE_APPLICATION_ERROR(-20007,'DATO NO ENCONTRADO');
	END IF;
	END;
END;	
	












