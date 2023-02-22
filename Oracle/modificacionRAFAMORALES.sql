--1
ALTER TABLE ENFERMO ADD CONSTRAINT CHK_SEXO CHECK (SEXO IN ('H','M'));

--3
ALTER TABLE ENFERMO MODIFY NSS VARCHAR2(12);

--4
INSERT INTO MEDICO(COD_MEDICO) VALUES (1);
INSERT INTO ENFERMO VALUES (1,'1234F','ANTONIO','H');
INSERT INTO ENFERMO VALUES (2,'2233H','MARIA','M');

--5
--COMO HEMOS BORRADO ANTES LA TABLA , LA VOLVEMOS A CREAR PARA PODER TRABAJAR CON ELLA

CREATE TABLE HABITACION 
(
	NUM_HAB NUMBER(5),
	NUMERO_CAMAS NUMBER(5),
	
	CONSTRAINT PK_HABITACION PRIMARY KEY (NUM_HAB),
	CONSTRAINT CHK_NUM_HAB CHECK (NUM_HAB BETWEEN 100 AND 399),
	CONSTRAINT CHK_NUM_CAMAS CHECK (NUMERO_CAMAS>=0 AND NUMERO_CAMAS<=3)
);

INSERT INTO HABITACION VALUES (102,2);
INSERT INTO INGRESO(COD_INGRESO, COD_INSCRIPCION,NUM_HAB) VALUES (000,1,102);
SELECT * FROM INGRESO;

--6
INSERT INTO VISITA(COD_MEDICO, COD_INSCRIPCION, FECHA) VALUES (1,1,SYSDATE);
SELECT * FROM VISITA;

--7
ALTER TABLE VISITA ADD FECHA_PROXIMA DATE;

--8
UPDATE ENFERMO SET NOMBRE='JOHN NIEVE' WHERE COD_INSCRIPCION=1;
UPDATE ENFERMO SET SEXO='H' WHERE COD_INSCRIPCION=1;
SELECT * FROM ENFERMO;

--10
DROP TABLE ENFERMO CASCADE CONSTRAINT;
DROP TABLE VISITA CASCADE CONSTRAINT;
DROP TABLE MEDICO CASCADE CONSTRAINT;
DROP TABLE HABITACION CASCADE CONSTRAINT;
DROP TABLE INGRESO CASCADE CONSTRAINT;



--EJERCICIO 3

--1) Creo la tabla llamada FACTURA e inserto datos ¿Podrá ver esos datos otro programador que trabaje en tu equipo y tenga acceso a la BDD?

--No, ya que si no hacemos commit los datos no se guardan, en este caso el otro programador verá la tabla creada (la creación de tablas tiene commit
-- implementado). Para que el programador lo vea, como ya hemos comentado antes, deberiamos hacer un commit para guardar los datos.


--2) Posteriormente creo otra tabla Cliente ¿Quedarán persistidos los datos en la base de datos?

--En este caso al crear otra tabla, toda instrución que hayamos realizado anteriormente quedara guardado en la base de datos, por que cuando 
--creamos una de estas se hace un commit. Por lo que los datos quedarán persistidos en la base de datos.


--3) Nos damos cuenta de que los datos están mal ¿Puedo volver a la situación inicial con alguna operación?

--En este caso como ya hemos creado la tabla Cliente y con ella se ha realizado un commit, no podriamos volver a la situación inicial, ya que si 
--hicieramos un rollback, este, volvería al último commit, es decir al de la tabla Cliente.


--4) Inserto datos en Clientes y quiero que queden persistidos ¿Qué operación necesito realizar?

--Debemos realizar un commit para que estos datos queden guardados en la base de datos, de lo contrario podriamos darle al rollback y volver hacia 
--el ultimo commit que se haya hecho.


--5) Quiero borrar algunos datos pero por error he borrado todos ¿Puedo realizar algo para recuperar los datos que borré?

--Para poder recuperar los datos que hemos borrado tendriamos que utilizar el rollback, que como ya hemos explicado antes, su función es volver 
--hasta el último commit que hayamos realizado. Para este caso, si hemos hecho un commit al insertar los datos, nada más que hay que utilizar un 
--rolllback para volver hacia este último commit y tener de nuevo todos los datos restaurados.


--6) ¿En qué consiste el SAVEPOINT?

--El SAVEPOINT es , como indica su nombre, un punto de guardado, funciona parecido a un commit pero con la felxibilidad de poder movernos 
--entre ellos mediante rollback. Si hicieramos un commit despues de un punto de guardado, este se perderia ya que podriamos volver hasta
--este ultimo commit.














