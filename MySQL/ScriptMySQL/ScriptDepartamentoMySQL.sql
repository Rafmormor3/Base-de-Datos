create database departamento;
use departamento;

CREATE TABLE DEPARTAMENTO
(
	CODIGO INTEGER(20) AUTO_INCREMENT , 
	DESCRIPCION VARCHAR(100),
	
	CONSTRAINT PK_DEPARTAMENTO PRIMARY KEY (CODIGO)
);

INSERT INTO DEPARTAMENTO(DESCRIPCION) VALUES ('LOGISTICA');
INSERT INTO DEPARTAMENTO(DESCRIPCION) VALUES ('DIRECCION');
INSERT INTO DEPARTAMENTO(DESCRIPCION) VALUES ('ADMINISTRACION');
INSERT INTO DEPARTAMENTO(DESCRIPCION) VALUES ('TECNICO');

SELECT * FROM DEPARTAMENTO;