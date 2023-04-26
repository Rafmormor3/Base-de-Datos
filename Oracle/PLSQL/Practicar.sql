CREATE OR REPLACE PROCEDURE SALUDAR IS 
SALUDO VARCHAR2(50);
BEGIN
	SALUDO:='HOLA MUNDO';
	dbms_output.put_line(SALUDO);
END;

BEGIN
	SALUDAR;
END;
--------------------------------------------

CREATE OR REPLACE PROCEDURE ESCRIBE_MENSAJE(TEXTO VARCHAR2) IS 
BEGIN
	dbms_output.put_line(TEXTO);
END;

BEGIN
	ESCRIBE_MENSAJE('RAFA MORALES');
END;
--------------------------------------------

CREATE OR REPLACE PROCEDURE SERIE(MINIMO NUMBER, MAXIMO NUMBER, PASO NUMBER) IS 
RESULTADO NUMBER;
BEGIN
	RESULTADO:=MINIMO;
	WHILE RESULTADO<=MAXIMO
	LOOP
		dbms_output.put_line(RESULTADO);
		RESULTADO:=RESULTADO+PASO;
	END LOOP;
	
END;

BEGIN
	SERIE(10, 20, 3);
END;
--------------------------------------------

CREATE OR REPLACE FUNCTION NOTA(N NUMBER) RETURN VARCHAR2 IS 
RES VARCHAR2(50);
BEGIN
	IF(N>=0 AND N<5) THEN
		RES:='SUSPENSO';
	ELSIF(N>=5 AND N<7) THEN 
		RES:='BIEN';
	ELSIF(N>=7 AND N<9) THEN 
		RES:='NOTABLE';
	ELSIF(N>=9 AND N<=10) THEN 
		RES:= 'SOBRESALIENTE';
	ELSE
		RES:='INVALIDO';
	END IF;

	RETURN RES;
END;

SELECT NOTA(-5) FROM DUAL;













