--1.Descuento medio aplicado en las facturas.
SELECT AVG(F.DTO) 
FROM  FACTURAS f; 

--2.Descuento medio aplicado en las facturas sin considerar los valores nulos.
SELECT AVG(F.DTO) 
FROM FACTURAS f 
WHERE F.DTO IS NOT NULL;

--3.Descuento medio aplicado en las facturas considerando los valores nulos como cero.
SELECT AVG(NVL(F.DTO,0)) 
FROM FACTURAS f ;

--4.Número de facturas.
SELECT COUNT(*) 
FROM FACTURAS f ;

--5.Número de pueblos de la Comunidad de Valencia.
SELECT COUNT(*) 
FROM PUEBLOS p , PROVINCIAS p2 
WHERE P.CODPRO = P2.CODPRO
 AND P2.NOMBRE IN ('VALENCIA', 'ALICANTE', 'CASTELLON');

--6.Importe total de los artículos que tenemos en el almacén. Este importe se calcula sumando el producto de las unidades en stock por el precio de cada unidad
SELECT SUM(A.STOCK*A.PRECIO)  
FROM ARTICULOS a ;

--7.Número de pueblos en los que residen clientes cuyo código postal empieza por ‘12’.
SELECT COUNT(C.CODPUE)
FROM CLIENTES c
WHERE C.CODPOSTAL LIKE '12%';

--8.Valores máximo y mínimo del stock de los artículos cuyo precio oscila entre 9 y 12 € y diferencia entre ambos valores
SELECT MAX(A.STOCK), MIN(A.STOCK) , MAX(A.STOCK)-MIN(A.STOCK) AS DIFERENCIA 
FROM ARTICULOS a 
WHERE A.PRECIO BETWEEN 9 AND 12

--9.Precio medio de los artículos cuyo stock supera las 10 unidades.
SELECT AVG(A.PRECIO) 
FROM ARTICULOS a 
WHERE A.STOCK >10;

--10.Fecha de la primera y la última factura del cliente con código 210.
SELECT  MAX(F.FECHA), MIN(F.FECHA) 
FROM FACTURAS f , CLIENTES c 
WHERE F.CODCLI = C.CODCLI 
 AND C.CODCLI = 210;

--11.Número de artículos cuyo stock es nulo.
SELECT COUNT(*) 
FROM ARTICULOS a 
WHERE A.STOCK IS NULL;

--12.Número de líneas cuyo descuento es nulo (con un decimal)
SELECT TO_CHAR(COUNT(DTO),'9.9') 
FROM LINEAS_FAC lf 
WHERE LF.DTO IS NULL; 

--13.Obtener cuántas facturas tiene cada cliente.
SELECT COUNT(F.CODFAC), f.CODCLI 
FROM FACTURAS f 
GROUP BY F.CODCLI ;

--14.Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o más  facturas.
SELECT COUNT(F.CODFAC)
FROM FACTURAS f , CLIENTES c
WHERE F.CODCLI = C.CODCLI 
HAVING COUNT(F.CODFAC) >=2; 

--15.Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de los  artículos
SELECT SUM(LF.CANT*LF.PRECIO) AS IMPORTE_FACTURACION
FROM LINEAS_FAC lf ;

--16.Importe de la facturación (suma del producto de la cantidad por el precio de las líneas de factura) de aquellos artículos cuyo código contiene la letra “A” (bien mayúscula o minúscula).
SELECT SUM(LF.CANT*LF.PRECIO) AS IMPORTE_FACTURACION
FROM LINEAS_FAC lf  
WHERE UPPER(LF.CODART) LIKE '%A%';

--17.Número de facturas para cada fecha, junto con la fecha
SELECT COUNT(FECHA), FECHA
FROM FACTURAS f 
GROUP BY FECHA ;

--18.Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que 
--más clientes tengan.
SELECT COUNT(C.CODCLI) AS NUMERO_CLIENTE, P.NOMBRE 
FROM CLIENTES c , PUEBLOS p 
WHERE C.CODPUE = P.CODPUE 
GROUP BY P.NOMBRE 
ORDER BY COUNT(C.CODCLI) DESC ;

--19.Obtener el número de clientes del pueblo junto con el nombre del pueblo mostrando primero los pueblos que más clientes 
--tengan, siempre y cuando tengan más de dos clientes.
SELECT COUNT(C.CODCLI) AS NUMERO_CLIENTE, P.NOMBRE 
FROM CLIENTES c , PUEBLOS p 
WHERE C.CODPUE = P.CODPUE 
GROUP BY P.NOMBRE
HAVING COUNT(C.CODCLI)>2  
ORDER BY COUNT(C.CODCLI) DESC ;

--20.Cantidades totales vendidas para cada artículo cuyo código empieza por “P", mostrando también la descripción de 
--dicho artículo.
SELECT COUNT(LF.CANT), A.DESCRIP 
FROM LINEAS_FAC lf, ARTICULOS a 
WHERE LF.CODART = A.CODART 
 AND A.CODART LIKE 'P%'
GROUP BY A.DESCRIP; 

--22.Nombre de aquellos artículos de los que se ha facturado más de 10000 euros.
SELECT A.DESCRIP 
FROM ARTICULOS a, LINEAS_FAC lf 
WHERE A.CODART = LF.CODART
 AND (LF.CANT * LF.PRECIO) >10000
GROUP BY A.DESCRIP  ;

--23.Número de facturas de cada uno de los clientes cuyo código está entre 150 y 300 (se debe mostrar este código), 
--con cada IVA distinto que se les ha aplicado.
SELECT 
FROM FACTURAS f 


--24.Media del importe de las facturas, sin tener en cuenta impuestos ni descuentos.



