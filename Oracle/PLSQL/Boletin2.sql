--1. Escribe un procedimiento que muestre el número de empleados y el salario
--mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
--uso de cursores implícitos, es decir utilizar SELECT ... INTO.

CREATE OR REPLACE PROCEDURE SALARIOS AS 

	NUM NUMBER;
	MINIMO NUMBER;
	MAXIMO NUMBER;
	MEDIA NUMBER;

BEGIN
	
	SELECT COUNT(EMPLEADOS.NUMEM), MIN(EMPLEADOS.SALAR), MAX(EMPLEADOS.SALAR), AVG(EMPLEADOS.SALAR) 
	INTO NUM,MINIMO,MAXIMO,MEDIA
	FROM EMPLEADOS
	WHERE EMPLEADOS.NUMDE = (SELECT DEPARTAMENTOS.NUMDE 
								FROM DEPARTAMENTOS 
								WHERE DEPARTAMENTOS.NOMDE LIKE 'FINANZAS');
	
	dbms_output.put_line('NUMERO EMPLEADOS: ' || NUM);
	dbms_output.put_line('SALARIO MINIMO: ' || MINIMO);
	dbms_output.put_line('SALARIO MAXIMO: ' || MAXIMO);
	dbms_output.put_line('SALRIO MEDIO: '|| MEDIA);

END;

BEGIN
	SALARIOS;
END;


--2. Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS
--con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se
--mostrar por pantalla el código de empleado, nombre, salario anterior y final.
--Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si
--por cualquier razón no es posible actualizar todos estos salarios, debe
--deshacerse el trabajo a la situación inicial.
CREATE OR REPLACE PROCEDURE AUMENTO
IS  
	CURSOR C3 IS 
	SELECT NUMEM , NOMEM , SALAR , ROWID
	FROM EMPLEADOS
	WHERE NUMHI >2 AND SALAR <2000;
	SALARIO_NUEVO NUMBER;
	
BEGIN
	FOR R_EMPLE IN C3
	LOOP
		SALARIO_NUEVO := R_EMPLE.SALAR*1.10;
		
		UPDATE EMPLEADOS SET SALAR = SALARIO_NUEVO
		WHERE NUMEM = R_EMPLE.NUMEM; 
	
		dbms_output.put_line(R_EMPLE.NUMEM || ' ' || R_EMPLE.NOMEM || ' ' || R_EMPLE.SALAR || ' ' || SALARIO_NUEVO);
	END LOOP;
	COMMIT;
	
	EXCEPTION
	WHEN OTHERS THEN
	ROLLBACK;

END ;

BEGIN
	AUMENTO;
END;
--3. Escribe un procedimiento que reciba dos parámetros (número de
--departamento, hijos). Deber. crearse un cursor explícito al que se le pasarán
--estos parámetros y que mostrar. los datos de los empleados que pertenezcan
--al departamento y con el número de hijos indicados. Al final se indicar. el
--número de empleados obtenidos.
CREATE OR REPLACE PROCEDURE DEPARTAMENTOSPLSQL.DATOS(NUM NUMBER, HIJOS NUMBER) IS 
	CURSOR C3(NUMDEP NUMBER, HIJOSEMPLE NUMBER) IS
	SELECT NOMEM ,NUMDE , NUMHI 
	FROM EMPLEADOS 
	WHERE NUMHI = HIJOSEMPLE 
	AND NUMDE  = NUMDEP;
	
	CONT NUMBER:=0;

BEGIN
	FOR REGISTRO IN C3(NUM,HIJOS)
	LOOP
		dbms_output.put_line(REGISTRO.NUMDE || ' '|| REGISTRO.NUMHI || ' '|| REGISTRO.NOMEM);
		CONT:=CONT+1;
	END LOOP;
		dbms_output.put_line('NUMERO DE EMPLEADOS: '||CONT);
END;

BEGIN
	DATOS(111,2);
END;

--4. Escribe un procedimiento con un parámetro para el nombre de empleado,
--que nos muestre la edad de dicho empleado en años, meses y días.
CREATE OR REPLACE PROCEDURE DEPARTAMENTOSPLSQL.EDAD(NOMBRE EMPLEADOS.NOMEM%TYPE) IS 

	CURSOR C(NOM EMPLEADOS.NOMEM%TYPE) IS 
	SELECT NOMEM, FECNA
	FROM EMPLEADOS
	WHERE NOMEM = NOM;
	
A NUMBER;
M NUMBER;
D NUMBER;

BEGIN
	FOR REGISTRO IN C(NOMBRE) 
	LOOP
		A:=EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM REGISTRO.FECNA);
		M:=A*12;
		D:=A*365;
		dbms_output.put_line(REGISTRO.NOMEM || ' AÑOS:'|| A || ' MESES:' || M || ' DIAS:' || D);
	END LOOP;
	
END;
	
BEGIN
	EDAD('CESAR');
END;





