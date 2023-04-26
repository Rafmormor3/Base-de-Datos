--1. Crea un paquete con la siguiente nomenclatura TUNOMBREgestioncarreras que contendrá la
--función y el procedimiento solicitados en el ejercicio 2 y ejercicio3. Es decir tendrá:
--+Función listadocaballos que no recibirá ningún parámetro y devolverá un número.
--+Procedimiento agregarcaballos que recibirá como argumento el nombre, peso, fecha
--de nacimiento, nacionalidad y el dni y el nombre del dueño.

--2. Implementa la FUNCIÓN listadocaballos que muestre en consola el siguiente listado y que
--devuelva el número de caballos mostrados en el listado. Deberás utilizar cursores e indicar en
--un comentario en el código el tipo de cursor que estás utilizando.

CREATE OR REPLACE PACKAGE MORALESGESTIONCARRERAS IS
VERSION NUMBER:=1.0;

	FUNCTION LISTADOCABALLOS RETURN NUMBER;
	PROCEDURE AGREGARCABALLOS (NOMBRECAB VARCHAR2, PESOCAB NUMBER, FECHANAC DATE, NACION VARCHAR2, DNIDUEÑO VARCHAR2, DUEÑO VARCHAR2);

END MORALESGESTIONCARRERAS;

CREATE OR REPLACE PACKAGE BODY MORALESGESTIONCARRERAS IS

	FUNCTION LISTADOCABALLOS RETURN NUMBER IS 
	
		CURSOR C_CABALLO IS 
		SELECT CABALLOS.NOMBRE AS CABNOMBRE , CABALLOS.PESO AS CABPESO , PERSONAS.NOMBRE AS NOMPERSON, CABALLOS.CODCABALLO 
		FROM CABALLOS, PERSONAS
		WHERE CABALLOS.PROPIETARIO = PERSONAS.CODIGO ;

		CURSOR C_CARRERAS(CODIGOCAB VARCHAR2) IS
		SELECT CARRERAS.NOMBRECARRERA , PERSONAS.NOMBRE , CARRERAS.FECHAHORA , PARTICIPACIONES.POSICIONFINAL, CARRERAS.IMPORTEPREMIO  
		FROM CARRERAS, PARTICIPACIONES, PERSONAS
		WHERE PARTICIPACIONES.CODCABALLO = CODIGOCAB
		 AND PARTICIPACIONES.JOCKEY = PERSONAS.CODIGO 
		 AND PARTICIPACIONES.CODCARRERA = CARRERAS.CODCARRERA ;
	
	CARRERAS_GANADAS NUMBER;
	TOTAL_IMPORTE NUMBER;
	TOTAL NUMBER:=0;

	BEGIN
		FOR REGISTRO_CAB IN C_CABALLO 
		LOOP
			CARRERAS_GANADAS:=0;
			TOTAL_IMPORTE:=0;
		
			dbms_output.put_line('CABALLO: ' || REGISTRO_CAB.CABNOMBRE);
			dbms_output.put_line('PESO: '|| REGISTRO_CAB.CABPESO);
			dbms_output.put_line('NOMBRE PROPIETARIO: ' || REGISTRO_CAB.NOMPERSON);
		
			FOR REGISTRO_CARRERA IN C_CARRERAS(REGISTRO_CAB.CODCABALLO)
			LOOP
				dbms_output.put_line('NOMBRE CARRERA: '||REGISTRO_CARRERA.NOMBRECARRERA||' JOCKEY: '||REGISTRO_CARRERA.NOMBRE||
										' FECHA: '|| REGISTRO_CARRERA.FECHAHORA|| ' POSICION FINAL: '||REGISTRO_CARRERA.POSICIONFINAL||
										' IMPORTE PREMIO: '|| REGISTRO_CARRERA.IMPORTEPREMIO);
			
				IF REGISTRO_CARRERA.POSICIONFINAL=1 THEN
					CARRERAS_GANADAS:=CARRERAS_GANADAS+1;
				END IF;
			
				
				TOTAL_IMPORTE:=TOTAL_IMPORTE+REGISTRO_CARRERA.IMPORTEPREMIO;
				
			END LOOP;
			TOTAL:=TOTAL+1;
			dbms_output.put_line('CARRERAS GANADAS: '|| CARRERAS_GANADAS);
			dbms_output.put_line('TOTAL IMPORTE PREMIOS: '|| TOTAL_IMPORTE);
		
		END LOOP;
		RETURN TOTAL;
	END;


	PROCEDURE AGREGARCABALLOS (NOMBRECAB VARCHAR2, PESOCAB NUMBER, FECHANAC DATE, NACION VARCHAR2, DNIDUEÑO VARCHAR2, DUEÑO VARCHAR2) IS
	DUEÑOS NUMBER;
	CODIGO_PERSON NUMBER;
	CODIGO_CAB NUMBER;

	COD NUMBER;
	BEGIN
		SELECT COUNT(PERSONAS.DNI)
		INTO DUEÑOS
		FROM PERSONAS, CABALLOS 
		WHERE PERSONAS.CODIGO = CABALLOS.PROPIETARIO 
		AND PERSONAS.DNI LIKE DNIDUEÑO;
	
		IF DUEÑOS = 0 THEN
			
			SELECT MAX(PERSONAS.CODIGO)+1
			INTO CODIGO_PERSON
			FROM PERSONAS;
		
			SELECT MAX(CABALLOS.CODCABALLO)+1
			INTO CODIGO_CAB
			FROM CABALLOS ;
		
		 	INSERT INTO PERSONAS(CODIGO,DNI,NOMBRE,APELLIDOS,DIRECCION,FECHA_NACIMIENTO) 
		 		VALUES (CODIGO_PERSON, DNIDUEÑO, DUEÑO, NULL,NULL,NULL);
		 	
		 	INSERT INTO CABALLOS(CODCABALLO, NOMBRE, PESO, FECHANACIMIENTO, PROPIETARIO, NACIONALIDAD) 
		 		VALUES(CODIGO_CAB, NOMBRECAB, PESOCAB, FECHANAC, CODIGO_PERSON, NACION);
		 	
		 ELSE
		 	
		 	SELECT CODIGO
		 	INTO COD
		 	FROM PERSONAS
		 	WHERE PERSONAS.DNI LIKE DNIDUEÑO;
		 
		 INSERT INTO CABALLOS(CODCABALLO, NOMBRE, PESO, FECHANACIMIENTO, PROPIETARIO, NACIONALIDAD) 
		 		VALUES(CODIGO_CAB, NOMBRECAB, PESOCAB, FECHANAC, COD, NACION);
		 	
		 END IF;
		 
	END;

	
END;

SELECT MORALESGESTIONCARRERAS.LISTADOCABALLOS FROM DUAL;

BEGIN
	MORALESGESTIONCARRERAS.AGREGARCABALLOS('ROCINANTE', 250, SYSDATE, 'ESPAÑA', '12345678L', 'ANTOÑITO');
END;

























