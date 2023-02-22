alter session set "_oracle_script"=true;  
create user MORALESMORENORAFA identified by MORALESMORENORAFA;
GRANT CONNECT, RESOURCE, DBA TO MORALESMORENORAFA;


CREATE TABLE MEDICO
(
	COD_MEDICO NUMBER(5),
	NOMBRE VARCHAR2(20),
	ESPECIALIDAD VARCHAR2(20) DEFAULT 'FAM',--5
	COD_DIRECTOR NUMBER(5),
	
	CONSTRAINT PK_MEDICO PRIMARY KEY (COD_MEDICO),
	CONSTRAINT FK_MEDICO FOREIGN KEY (COD_DIRECTOR) REFERENCES MEDICO(COD_MEDICO) ON DELETE SET NULL --7
);

CREATE TABLE ENFERMO
(
	COD_INSCRIPCION NUMBER(5),
	NSS VARCHAR2(10),
	NOMBRE VARCHAR2(20),
	SEXO VARCHAR2(1),
	
	CONSTRAINT PK_ENFERMO PRIMARY KEY (COD_INSCRIPCION)
);

CREATE TABLE HABITACION 
(
	NUM_HAB NUMBER(5),
	NUMERO_CAMAS NUMBER(5),
	
	CONSTRAINT PK_HABITACION PRIMARY KEY (NUM_HAB),
	CONSTRAINT CHK_NUM_HAB CHECK (NUM_HAB BETWEEN 100 AND 399), --2
	CONSTRAINT CHK_NUM_CAMAS CHECK (NUMERO_CAMAS>=0 AND NUMERO_CAMAS<=3) --3
);

CREATE TABLE INGRESO 
(
	COD_INGRESO NUMBER(5),
	COD_INSCRIPCION NUMBER(5),
	FECHA_INGRESO DATE DEFAULT SYSDATE,--1
	FECHA_ALTA DATE,
	NUM_HAB NUMBER(5),
	
	CONSTRAINT PK_INGRESO PRIMARY KEY (COD_INGRESO),
	CONSTRAINT FK1_INGRESO FOREIGN KEY (NUM_HAB) REFERENCES HABITACION(NUM_HAB) ON DELETE CASCADE, --6
	CONSTRAINT FK2_INGRESO FOREIGN KEY (COD_INSCRIPCION) REFERENCES ENFERMO(COD_INSCRIPCION) ON DELETE CASCADE,--9
	CONSTRAINT CHK_FECHA_ALTA CHECK (FECHA_ALTA>FECHA_INGRESO)--4
);

CREATE TABLE VISITA 
(
	COD_MEDICO NUMBER(5),
	COD_INSCRIPCION NUMBER(5),
	FECHA DATE,
	DIAGNOSTICO VARCHAR2(20),
	
	CONSTRAINT PK_VISITA PRIMARY KEY (COD_MEDICO, COD_INSCRIPCION),
	CONSTRAINT FK1_VISITA FOREIGN KEY (COD_MEDICO) REFERENCES MEDICO(COD_MEDICO) ON DELETE CASCADE,--8
	CONSTRAINT FK2_VISITA FOREIGN KEY (COD_INSCRIPCION) REFERENCES ENFERMO(COD_INSCRIPCION) ON DELETE CASCADE --9
);

DROP TABLE HABITACION CASCADE CONSTRAINT ; --10









