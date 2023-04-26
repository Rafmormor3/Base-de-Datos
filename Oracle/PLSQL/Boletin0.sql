--1
BEGIN
	IF 10 > 5 THEN
	DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
	DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;
--Cierto

--2
BEGIN
	IF 10 > 5 AND 5 > 1 THEN
	 DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
	 DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;
--Cierto

--3
BEGIN
	IF 10 > 5 AND 5 > 50 THEN
	 DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
	 DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;
--Falso

--4
BEGIN
	CASE
	 WHEN 10 > 5 AND 5 > 50 THEN
	 DBMS_OUTPUT.PUT_LINE ('Cierto');
	 ELSE
	 DBMS_OUTPUT.PUT_LINE ('Falso');
	END CASE;
END;
--Falso

--5
BEGIN
 FOR i IN 1..10 LOOP
 DBMS_OUTPUT.PUT_LINE (i);
 END LOOP;
END;
-- Muestra los numeros del 1 al 10

--6
BEGIN
 FOR i IN REVERSE 1..10 LOOP
 DBMS_OUTPUT.PUT_LINE (i);
 END LOOP;
END;
--Muestra los numeros del 10 al 1

--7
DECLARE
	num NUMBER(3) := 0;
BEGIN
	WHILE num<=100 LOOP
		DBMS_OUTPUT.PUT_LINE (num);
		num:= num+2;
	END LOOP;
END;
--Muestra los numeros pares desde el 0 al 100, (0,2,4,6,...,98,100)

--8
DECLARE
	num NUMBER(3) := 0;
BEGIN
	LOOP
	DBMS_OUTPUT.PUT_LINE (num);
	IF num > 100 THEN EXIT; 
	END IF;
	num:= num+2;
	END LOOP;
END;
--Muestra los numeros pares desde el 0 hasta el 102

--9
DECLARE
	num NUMBER(3) := 0;
BEGIN
	LOOP
	DBMS_OUTPUT.PUT_LINE (num);
	EXIT WHEN num > 100;
	num:= num+2;
	END LOOP;
END;
--Muestra los numeros pares desde el 0 hasta el 102











