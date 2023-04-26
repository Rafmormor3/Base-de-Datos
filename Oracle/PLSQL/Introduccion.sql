DECLARE
  FECHA DATE;
BEGIN
  SELECT SYSDATE INTO FECHA FROM DUAL;
  DBMS_OUTPUT.PUT_LINE
  (
    to_CHAR(fecha,'day", "dd" de "month" de "yyyy", a las "hh24:mi:ss')
  );
END;

------------------------------------------------------------------------
DECLARE
   A NUMBER := 4;
   B NUMBER := 2;
   C NUMBER;

BEGIN

  IF  A IS NULL OR B IS NULL THEN
    C := 3;
  ELSIF A < B THEN
    C := 1;
  ELSE
    C := 2;
  END IF;
  DBMS_OUTPUT.PUT_LINE ('El valor de C es ' || C);

END;
------------------------------------------------------------------------------

DECLARE
	NOTA NUMBER := 8;
BEGIN
	IF NOTA IS NULL  OR NOTA<0 OR NOTA>10 THEN
		DBMS_OUTPUT.PUT_LINE('NOTA NO VALIDA');
	ELSIF NOTA>=0 AND NOTA<5 THEN 
		DBMS_OUTPUT.PUT_LINE('INSUFICIENTE');
	ELSIF NOTA>=5 AND NOTA<6 THEN 
		DBMS_OUTPUT.PUT_LINE('SUFICIENTE');
	ELSIF NOTA>=6 AND NOTA<7 THEN 
		DBMS_OUTPUT.PUT_LINE('BIEN');
	ELSIF NOTA>=7 AND NOTA<9 THEN 
		DBMS_OUTPUT.PUT_LINE('NOTABLE');
	ELSE
		DBMS_OUTPUT.PUT_LINE('SOBRESALIENTE');
	END IF;
END;

------------------------------------------------------------

CREATE TABLE TABLA_TEMP 
(
	NUMERO NUMBER(6)
);

DECLARE 
	I NUMBER:=1;
BEGIN
	LOOP
		INSERT INTO TABLA_TEMP VALUES (I*10);
		EXIT WHEN I>=10;
		I:=I+1;
	END LOOP;
	
END;

SELECT * FROM TABLA_TEMP;


