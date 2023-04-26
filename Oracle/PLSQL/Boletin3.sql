--1. Realiza un procedimiento que reciba un número de departamento y muestre por pantalla su nombre y localidad.
CREATE OR REPLACE PROCEDURE DEP(NUMDEP DEPT.DEPTNO%TYPE) IS
	NOMBRE DEPT.DNAME%TYPE ; 
	LOCALIDAD DEPT.LOC%TYPE;
BEGIN
	SELECT DEPT.DNAME , DEPT.LOC 
	INTO NOMBRE, LOCALIDAD
	FROM DEPT 
	WHERE DEPT.DEPTNO = NUMDEP;
	
	dbms_output.put_line('NOMBRE: '|| NOMBRE || ' LOCALIDAD: '|| LOCALIDAD);
END;

BEGIN
	DEP(10);
END;



--2. Realiza una función devolver_sal que reciba un nombre de departamento y devuelva la suma de sus salarios.
CREATE OR REPLACE FUNCTION BOLETIN4PLSQL.DEVOLVER_SAL(NOMBREDEPT DEPT.DNAME%TYPE)
RETURN NUMBER
IS
SUMA NUMBER;
BEGIN
	SELECT SUM(EMP.SAL) 
	INTO SUMA 
	FROM EMP, DEPT
	WHERE EMP.DEPTNO = DEPT.DEPTNO 
	AND DEPT.DNAME = NOMBREDEPT;
	
	RETURN SUMA;
END DEVOLVER_SAL;

SELECT DEVOLVER_SAL('SALES') FROM DUAL;


--3. Realiza un procedimiento MostrarAbreviaturas que muestre las tres primeras letras del nombre de cada empleado.
CREATE OR REPLACE PROCEDURE MOSTRARABREVIATURAS IS 
	CURSOR C3 IS 
	SELECT EMP.ENAME  
	FROM EMP;
	NOMBRE EMP.ENAME%TYPE;
BEGIN
	FOR REGISTRO IN C3
	LOOP
		NOMBRE:=SUBSTR(REGISTRO.ENAME,0,3);
		dbms_output.put_line(NOMBRE);
	END LOOP;
END;

BEGIN
	MOSTRARABREVIATURAS;
END;

--4. Realiza un procedimiento que reciba un número de departamento y muestre una lista de sus empleados.
CREATE OR REPLACE PROCEDURE EMPLEADOS(NUMERODEP EMP.DEPTNO%TYPE) IS 
	
CURSOR C4(NUMDEPARTAMENTO EMP.DEPTNO%TYPE) IS 
	SELECT EMP.ENAME
	FROM EMP
	WHERE DEPTNO = NUMDEPARTAMENTO;

BEGIN
	
	FOR REGISTRO IN C4(NUMERODEP)
	LOOP
		dbms_output.put_line(REGISTRO.ENAME);
	END LOOP;
END;

BEGIN
	EMPLEADOS(10);
END;


--5. Realiza un procedimiento MostrarJefes que reciba el nombre de un departamento y muestre
--los nombres de los empleados de ese departamento que son jefes de otros empleados.Trata las
--excepciones que consideres necesarias.

--EXCEPTION PERSONALIZADA
CREATE OR REPLACE PROCEDURE MOSTRARJEFES(NOMBREDEPT DEPT.DNAME%TYPE) IS

	CURSOR C5(NOMBRE DEPT.DNAME%TYPE) IS
	SELECT EMP.ENAME 
	FROM EMP, DEPT
	WHERE EMP.DEPTNO = DEPT.DEPTNO 
	AND EMP.EMPNO IN (SELECT EMP.MGR 
						FROM EMP)
	AND DEPT.DNAME LIKE NOMBRE;

	CONTADOR NUMBER:=0;

BEGIN
	
	SELECT COUNT( DISTINCT EMP.ENAME) 
	INTO CONTADOR
	FROM EMP, DEPT
	WHERE EMP.DEPTNO = DEPT.DEPTNO 
	AND EMP.EMPNO IN (SELECT EMP.MGR 
						FROM EMP)
	AND DEPT.DNAME LIKE NOMBREDEPT;

	IF CONTADOR = 0 THEN
		RAISE_APPLICATION_ERROR(-20001, 'DEPARTAMENTO NO APLICADO');
	END IF;
	
	FOR REGISTRO IN C5(NOMBREDEPT)
	LOOP
		dbms_output.put_line(REGISTRO.ENAME);
	END LOOP;

END;

BEGIN
	MOSTRARJEFES('SALES');
END;


--6. Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es 7082
CREATE OR REPLACE PROCEDURE EMPLEUNICO IS
EMPLEADO EMP%ROWTYPE;
BEGIN 
	SELECT * 
	INTO EMPLEADO
	FROM EMP 
	WHERE EMP.EMPNO =7082;
	
	dbms_output.put_line(EMPLEADO.ENAME || ' ' || EMPLEADO.SAL);

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('No Hay Dato');

END;

BEGIN
	EMPLEUNICO;
END;



--7. Realiza un procedimiento llamado HallarNumEmp que recibiendo un nombre de
--departamento, muestre en pantalla el número de empleados de dicho departamento
--Si el departamento no tiene empleados deberá mostrar un mensaje informando de ello. Si el
--departamento no existe se tratará la excepción correspondiente.
CREATE OR REPLACE PROCEDURE HALLARNUMEMP(NOMBREDEPART DEPT.DNAME%TYPE) IS
CONT NUMBER;
BEGIN
	SELECT COUNT(EMP.EMPNO)
	INTO CONT
	FROM EMP, DEPT
	WHERE EMP.DEPTNO = DEPT.DEPTNO 
	AND DEPT.DNAME LIKE NOMBREDEPART;

	IF CONT = 0 THEN
		dbms_output.put_line('No tiene empleados');
	ELSE
		dbms_output.put_line(CONT);	
	END IF;

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		dbms_output.put_line('No Hay Dato'); 

END;

BEGIN
	HALLARNUMEMP('SALES');
END;



--8. Hacer un procedimiento que reciba como parámetro un código de empleado y devuelva su nombre.
CREATE OR REPLACE PROCEDURE NOMBREEMPLE(CODEMPLE EMP.EMPNO%TYPE) IS 
EMPLEADO EMP%ROWTYPE;
BEGIN
	SELECT *
	INTO EMPLEADO 
	FROM EMP 
	WHERE EMP.EMPNO = CODEMPLE;

	dbms_output.put_line(EMPLEADO.ENAME);
END;

BEGIN
	NOMBREEMPLE(7369);
END;

--9. Codificar un procedimiento que reciba una cadena y la visualice al revés.
CREATE OR REPLACE PROCEDURE RIVERSADA(CADENA VARCHAR2) IS 
REVES VARCHAR2(50);
LEN NUMBER;
BEGIN
	LEN:=LENGTH(CADENA);
	FOR I IN REVERSE 1..LEN
	LOOP
		REVES:= REVES || SUBSTR(CADENA,I,1);
	END LOOP;
	dbms_output.put_line(REVES);
	
END;

BEGIN
	RIVERSADA('JOSE JUAN');
END;

-----------------------------------------------
CREATE OR REPLACE FUNCTION BOLETIN4PLSQL.RIVERSADA2(CADENA VARCHAR2)
RETURN VARCHAR2
IS
REVES VARCHAR2(50);
LEN NUMBER;
BEGIN
	LEN:=LENGTH(CADENA);
	FOR I IN REVERSE 1..LEN
	LOOP
		REVES:= REVES || SUBSTR(CADENA,I,1);
	END LOOP;
	RETURN REVES;
	
END RIVERSADA2;

SELECT RIVERSADA2('JOSE JUAN') FROM DUAL;


--10. Escribir un procedimiento que reciba una fecha y escriba el año, en número, correspondiente a esa fecha.
CREATE OR REPLACE PROCEDURE ANYO(FECHA DATE) IS 
NUM NUMBER;
BEGIN
	NUM:=EXTRACT(YEAR FROM FECHA);
	dbms_output.put_line(NUM);
END;

BEGIN
	ANYO(TO_DATE('2002/05/09','yyyy/mm/dd'));
END;


--11. Realiza una función llamada CalcularCosteSalarial que reciba un nombre de departamento y
--devuelva la suma de los salarios y comisiones de los empleados de dicho departamento.
CREATE OR REPLACE FUNCTION BOLETIN4PLSQL.CALCULARCOSTESALARIAL(NOMBREDEPT DEPT.DNAME%TYPE)
RETURN NUMBER
IS
SUMA NUMBER;
COMISIONES NUMBER;
TOTAL NUMBER;
NOMBRE VARCHAR2(50);
BEGIN
	
	SELECT DNAME 
	INTO NOMBRE 
	FROM DEPT 
	WHERE DEPT.DNAME LIKE NOMBREDEPT;
	
	SELECT SUM(EMP.SAL), SUM(NVL(EMP.COMM,0))
	INTO SUMA, COMISIONES 
	FROM EMP, DEPT
	WHERE EMP.DEPTNO = DEPT.DEPTNO 
	AND DEPT.DNAME = NOMBREDEPT;

	TOTAL:=SUMA+COMISIONES;
	
	RETURN TOTAL;
	
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	dbms_output.put_line('NO DATOS ENCONTRADOS');
	RETURN -1;

END ;


SELECT CALCULARCOSTESALARIAL('HOLA') FROM DUAL;

DECLARE 
TOTAL NUMBER;
BEGIN
	TOTAL:=CALCULARCOSTESALARIAL('H0LA');
	dbms_output.put_line(TOTAL);
END;

--12. Codificar un procedimiento que permita borrar un empleado cuyo número se pasará en la
--llamada. Si no existiera dar el correspondiente mensaje de error.
CREATE OR REPLACE PROCEDURE BOLETIN4PLSQL.ELIMINAREMPLE(NUMEMP EMP.EMPNO%TYPE) IS 

BEGIN
	
	DELETE FROM EMP WHERE EMP.EMPNO = NUMEMP;
	IF SQL%NOTFOUND THEN
		RAISE_APPLICATION_ERROR(-20004,'NO EXISTE');
	END IF;
END;

BEGIN
	ELIMINAREMPLE(45);
END;

--13. Realiza un procedimiento MostrarCostesSalariales que muestre los nombres de todos los
--departamentos y el coste salarial de cada uno de ellos
CREATE OR REPLACE PROCEDURE MOSTRARCOSTESALARIALES IS 
	CURSOR C13 IS 
	SELECT DEPT.DNAME , SUM(EMP.SAL) AS SUMA
	FROM EMP, DEPT
	WHERE EMP.DEPTNO(+) = DEPT.DEPTNO
	GROUP BY DEPT.DNAME ;

BEGIN
	FOR REGISTRO IN C13
	LOOP
		dbms_output.put_line(REGISTRO.DNAME || ' ' || REGISTRO.SUMA);
	END LOOP;
END;

BEGIN
	MOSTRARCOSTESALARIALES;
END;


--14. Escribir un procedimiento que modifique la localidad de un departamento. El procedimiento
--recibirá como parámetros el número del departamento y la localidad nueva.
CREATE OR REPLACE PROCEDURE MODLOCALIDAD(NUMERODEP DEPT.DEPTNO%TYPE, NUEVALOC DEPT.LOC%TYPE) IS
BEGIN 
	
	UPDATE DEPT SET DEPT.LOC = NUEVALOC WHERE DEPT.DEPTNO = NUMERODEP;
	IF SQL%NOTFOUND THEN
	RAISE_APPLICATION_ERROR(-20005,'NO EXISTE');
	END IF;
	dbms_output.put_line('ACTUALIZADO');
END;

BEGIN
	MODLOCALIDAD(40,'VALENCIA');
END;


--15. Realiza un procedimiento MostrarMasAntiguos que muestre el nombre del empleado más
--antiguo de cada departamento junto con el nombre del departamento. Trata las excepciones
--que consideres necesarias.

CREATE OR REPLACE PROCEDURE MostrarMasAntiguos IS 
	CURSOR C_NOMBRE IS 
	SELECT ENAME
	FROM EMP, DEPT D1
	WHERE D1.DEPTNO = EMP.DEPTNO 
	AND EMP.ENAME IN (SELECT *
						FROM(SELECT ENAME 
							FROM EMP
							WHERE DEPTNO = D1.DEPTNO 
							ORDER BY EMP.HIREDATE DESC)
						WHERE ROWNUM=1);
BEGIN
	FOR REGISTROS IN C_NOMBRE
	LOOP
		dbms_output.put_line(REGISTROS.ENAME);
	END LOOP;
	
END;

BEGIN
	MostrarMasAntiguos;
END;
















