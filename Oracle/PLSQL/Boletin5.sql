--1. Crear un procedimiento que en la tabla emp incremente el salario el 10% a los empleados que
--tengan una comisión superior al 5% del salario.
CREATE OR REPLACE PROCEDURE INCREMENTO IS 
BEGIN 
	UPDATE EMP SET SAL=SAL+(SAL*0.10) WHERE EMP.COMM > SAL *0.05; 
END;

BEGIN
	INCREMENTO;
END;


--2. Realiza un procedimiento MostrarMejoresVendedores que muestre los nombres de los dos
--vendedores/as con más comisiones.
CREATE OR REPLACE PROCEDURE MOSTRARMEJORESVENDEDORES IS 
	CURSOR C_NOMBRES IS 
	SELECT EMP.ENAME 
	FROM EMP
	WHERE DEPTNO =30
	AND COMM =(SELECT MAX(COMM)
				FROM EMP);
BEGIN
	FOR REGISTRO IN C_NOMBRES
	LOOP
		dbms_output.put_line(REGISTRO.ENAME);
	END LOOP;
END;

BEGIN
	MOSTRARMEJORESVENDEDORES;
END;
-----------------------------------------------------------------
CREATE OR REPLACE PROCEDURE BOLETIN4PLSQL.MOSTRARMEJORESVENDEDORES2 IS 
	CURSOR C_NOMBRES IS 
	SELECT *
	FROM (SELECT ENAME
			FROM EMP
			WHERE EMP.DEPTNO=30
			AND EMP.COMM IS NOT NULL
			ORDER BY EMP.COMM DESC)
	WHERE ROWNUM<3;
BEGIN
	FOR REGISTRO IN C_NOMBRES
	LOOP
		dbms_output.put_line(REGISTRO.ENAME);
	END LOOP;
END;

BEGIN
	MOSTRARMEJORESVENDEDORES2;
END;

			
--3. Realiza un procedimiento MostrarsodaelpmE que reciba el nombre de un departamento al
--revés y muestre los nombres de los empleados de ese departamento.
CREATE OR REPLACE PROCEDURE MostrarsodaelpmE (NOMBREDEPR DEPT.DNAME%TYPE) IS 
	
	CURSOR C_EMPLEADOS(NOMBRE DEPT.DNAME%TYPE) IS
	SELECT EMP.ENAME
	FROM EMP, DEPT
	WHERE EMP.DEPTNO = DEPT.DEPTNO 
	AND DEPT.DNAME = NOMBRE;

BEGIN
	FOR REGISTRO IN C_EMPLEADOS(RIVERSADA2(NOMBREDEPR))
	LOOP
		dbms_output.put_line(REGISTRO.ENAME);
	END LOOP;
	
END;

BEGIN
	MostrarsodaelpmE('SELAS');
END;


--4. Realiza un procedimiento RecortarSueldos que recorte el sueldo un 20% a los empleados
--cuyo nombre empiece por la letra que recibe como parámetro. Trata las excepciones que
--consideres necesarias.
CREATE OR REPLACE PROCEDURE RecortarSueldos(INICIO VARCHAR2) IS 
BEGIN 
	
	UPDATE EMP SET SAL=SAL-(SAL*0.2) WHERE UPPER(LPAD(ENAME,1))=UPPER(INICIO);
	
	IF SQL%NOTFOUND THEN
		RAISE_APPLICATION_ERROR(-20010,'NO EXISTE');
	ELSE
		dbms_output.put_line('HECHO');
	END IF;
	COMMIT;

	EXCEPTION
	WHEN OTHERS THEN
	ROLLBACK;
END;

BEGIN
	RecortarSueldos('A');
END;



--5. Realiza un procedimiento BorrarBecarios que borre a los dos empleados más nuevos de cada
--departamento.
CREATE OR REPLACE PROCEDURE BorrarBecarios IS 
	CURSOR C5_EMPLE IS  
	SELECT ENAME, DNAME
	FROM EMP, DEPT D1
	WHERE EMP.DEPTNO = D1.DEPTNO 
	AND EMP.HIREDATE IN (SELECT *
							FROM (SELECT HIREDATE 
									FROM EMP
									WHERE DEPTNO=D1.DEPTNO
									ORDER BY HIREDATE)
							WHERE ROWNUM<3);
BEGIN
	FOR REGISTROS IN C5_EMPLE
	LOOP
		DELETE FROM EMP WHERE EMP.ENAME = REGISTROS.ENAME;
		
		IF SQL%NOTFOUND THEN
			RAISE_APPLICATION_ERROR(-20008,'NO ENCONTRADO');
	END LOOP;
	
END;

BEGIN
	BorrarBecarios;
END;

-------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE LISTADOEMPLEADOS IS 
	
	CURSOR C_DEP IS 
	SELECT *
	FROM DEPT;

	CURSOR C_EMP(CODIGODEPT NUMBER) IS
	SELECT *
	FROM EMP
	WHERE EMP.DEPTNO = CODIGODEPT;

BEGIN
	FOR FILADEPT IN C_DEP
	LOOP
		dbms_output.put_line('DEPARTAMENTO: '||FILADEPT.DNAME);
	
		FOR FILAEMPLE IN C_EMP(FILADEPT.DEPTNO)
		LOOP
			dbms_output.put_line('NOMBRE: '||FILAEMPLE.ENAME);
		END LOOP;
		
	END LOOP;
END;

BEGIN
	LISTADOEMPLEADOS;
END;











