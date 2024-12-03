/* Teniendo en cuenta el Modelo de Datos transaccional creado, que resuelve la gestión de
las publicaciones, ventas, pagos, envíos y facturación del Marketplace, se deberá
generar un nuevo modelo de datos, de Inteligencia de Negocios, que permita unicar la
información necesaria para facilitar la creación de los tableros de control a nivel
gerencial.
Se deberán considerar como mínimo, las siguientes dimensiones además de las que el
alumno considere convenientes:
? Tiempo : año/cuatrimestre/mes
? Ubicación: Provincia/Localidad
? Rango etario clientes
? < 25
? 25 - 35
? 35 - 50
? > 50
? Rango horario ventas
? 00:00 - 06:00
? 06:00 - 12:00
? 12:00 - 18:00
? 18:00 - 24:00
? Tipo Medio de Pago
? Tipo Envio
? Rubro/SubRubro de Productos/Publicación
12
En función de estas dimensiones se deberán realizar una serie de vistas que deberán
proveer, en forma simple desde consultas directas la siguiente información para los
indicadores de negocio:


1. Promedio de tiempo de publicaciones. Tiempo promedio que se encuentra
vigente una publicación según el subRubro asociado a los productos de la misma
para cada cuatrimestres de cada año. Se calcula en función de la diferencia entre
la fecha de inicio y n. Se toma en cuenta la fecha de inicio.

2. Promedio de Stock Inicial. Cantidad de stock promedio con que se dan de alta
las publicaciones según la Marca de los productos publicados por año.

3. Venta promedio mensual. Valor promedio de las ventas (en $) según la
provincia correspondiente a la ubicación del almacén para cada mes de cada año
Se calcula en función de la sumatoria del importe de las ventas sobre el total de
las mismas.

4. Rendimiento de rubros. Los 5 rubros con mayores ventas para cada
cuatrimestre de cada año según la localidad y rango etario de los clientes.

5. Volumen de ventas. Cantidad de ventas registradas por rango horario según el
mes de cada año.

6. Pago en Cuotas. Las 3 localidades con el mayor importe de pagos en cuotas,
según el medio de pago, mes y año. Se calcula sumando los importes totales de
todas las ventas en cuotas. Se toma la localidad del cliente (Si tiene más de una
dirección se toma a la que seleccionó el envío)

7. Porcentaje de cumplimiento de envíos en los tiempos programados por
provincia (del almacén) por año/mes (desvío). Se calcula teniendo en cuenta los
envíos cumplidos sobre el total de envíos para el período.

8. Localidades que pagan mayor costo de envío. Las 5 localidades (tomando la
localidad del cliente) con mayor costo de envío.

9. Porcentaje de facturación por concepto para cada mes de cada año. Se calcula
en función del total del concepto sobre el total del período.

10. Facturación por provincia. Monto facturado según la provincia del vendedor
para cada cuatrimestre de cada año.
*/




IF OBJECT_ID('CHIRIPIORCA.BI_HECHO_FACTURACION ','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_HECHO_FACTURACION
    GO
    IF OBJECT_ID('CHIRIPIORCA.BI_HECHO_EVENTO_PROVINCIA_ALMACEN','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_HECHO_EVENTO_PROVINCIA_ALMACEN;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_HECHO_PAGO ','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_HECHO_PAGO
    GO
    IF OBJECT_ID('CHIRIPIORCA.BI_HECHO_EVENTO_LOCALIDAD_CLIENTE','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_HECHO_EVENTO_LOCALIDAD_CLIENTE;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_HECHO_PUBLICACION','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_HECHO_PUBLICACION;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_CONCEPTO_FACTURA','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_CONCEPTO_FACTURA;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_MARCA','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_MARCA;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_SUBRUBRO','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_SUBRUBRO;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_TIPO_ENVIO','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_TIPO_ENVIO;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_TIPO_MEDIO_DE_PAGO','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_TIPO_MEDIO_DE_PAGO;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_RANGO_HORARIO_VENTAS','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_RANGO_HORARIO_VENTAS;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_UBICACION','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_UBICACION;
GO
IF OBJECT_ID('CHIRIPIORCA.BI_TIEMPO','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.BI_TIEMPO;
GO
IF OBJECT_ID('CHIRIPIORCA.Rango_horario_ventas','U') IS NOT NULL
DROP TABLE CHIRIPIORCA.Rango_horario_ventas;
GO





IF OBJECT_ID('CHIRIPIORCA.OBTENER_ID_RANGO_ETARIO') IS NOT NULL
DROP FUNCTION CHIRIPIORCA.OBTENER_ID_RANGO_ETARIO;
GO

--DROPS MIGRACIONES DIMENSIONES
IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_TIEMPO') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_TIEMPO;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_UBICACION') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_UBICACION;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_ETARIO_CLIENTES') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_ETARIO_CLIENTES;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_HORARIO_VENTAS') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_HORARIO_VENTAS;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_MEDIO_DE_PAGO') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_MEDIO_DE_PAGO;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_ENVIO') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_ENVIO;
GO 

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_SUBRUBRO') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_SUBRUBRO;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_MARCA') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_MARCA;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_DIMENSION_CONCEPTO_FACTURA') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_CONCEPTO_FACTURA;
GO


-- DROPS MIGRACIONES TABLAS HECHOS
IF OBJECT_ID('CHIRIPIORCA.migrar_facturacion') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.migrar_facturacion;
GO

IF OBJECT_ID('CHIRIPIORCA.BI_MIGRACION_PUBLICACION') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.BI_MIGRACION_PUBLICACION;
GO

IF OBJECT_ID('CHIRIPIORCA.evento_provincia_envio') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.evento_provincia_envio;
GO

IF OBJECT_ID('CHIRIPIORCA.localidad_cliente') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.localidad_cliente;
GO

IF OBJECT_ID('CHIRIPIORCA.MIGRAR_PAGOS') IS NOT NULL
DROP PROCEDURE CHIRIPIORCA.MIGRAR_PAGOS;
GO

--DROP VIEWS

IF OBJECT_ID('CHIRIPIORCA.PROM_TIEMPO_PUBLICACIONES_VW') IS NOT NULL
DROP VIEW CHIRIPIORCA.PROM_TIEMPO_PUBLICACIONES_VW
    GO

    IF OBJECT_ID('CHIRIPIORCA.PROMEDIO_STOCK_INICIAL_VW') IS NOT NULL
DROP VIEW CHIRIPIORCA.PROMEDIO_STOCK_INICIAL_VW
    GO

    IF OBJECT_ID('CHIRIPIORCA.VENTA_PROMEDIO_MENSUAL_VW') IS NOT NULL
DROP VIEW CHIRIPIORCA.VENTA_PROMEDIO_MENSUAL_VW
    GO

    IF OBJECT_ID('CHIRIPIORCA.MEJORES_CINCO_RUBROS_VW') IS NOT NULL
DROP VIEW CHIRIPIORCA.MEJORES_CINCO_RUBROS_VW
    GO

    IF OBJECT_ID('CHIRIPIORCA.MEJORES_TRES_LOCALIDADES_VW') IS NOT NULL
DROP VIEW CHIRIPIORCA.MEJORES_TRES_LOCALIDADES_VW
    GO

    IF OBJECT_ID('CHIRIPIORCA.PORCENTAJE_DE_CUMPLIMIENTO_DE_ENVIOS') IS NOT NULL
DROP VIEW CHIRIPIORCA.PORCENTAJE_DE_CUMPLIMIENTO_DE_ENVIOS
    GO

    IF OBJECT_ID('CHIRIPIORCA.LAS_CINCO_LOCALIDADES_MAYOR_COSTO_ENVIO') IS NOT NULL
DROP VIEW CHIRIPIORCA.LAS_CINCO_LOCALIDADES_MAYOR_COSTO_ENVIO
    GO

    IF OBJECT_ID('CHIRIPIORCA.PORCENTAJE_FACTURACION_X_CONCEPTO') IS NOT NULL
DROP VIEW CHIRIPIORCA.PORCENTAJE_FACTURACION_X_CONCEPTO;

IF OBJECT_ID('CHIRIPIORCA.FACTURACION_X_PROVINCIA') IS NOT NULL
DROP VIEW CHIRIPIORCA.FACTURACION_X_PROVINCIA;
GO



CREATE TABLE CHIRIPIORCA.BI_TIEMPO(
                                      bi_tiempo_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                      bi_tiempo_anio DECIMAL(4, 0),
                                      bi_tiempo_mes DECIMAL(2, 0),
                                      bi_tiempo_cuatrimestre DECIMAL(1, 0)
);
GO
CREATE TABLE CHIRIPIORCA.BI_UBICACION (
                                          bi_ubic_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                          bi_ubic_provincia varchar(255),
                                          bi_ubic_localidad varchar(255)
);
GO
CREATE TABLE CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES (
                                                      bi_rango_etario_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                                      bi_rango_etario_nombre VARCHAR(255)
);
GO
CREATE TABLE CHIRIPIORCA.Rango_horario_ventas (
                                                  bi_rango_horario_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                                  bi_rango_horario_nombre VARCHAR(100)
);
GO


CREATE TABLE CHIRIPIORCA.BI_tipo_medio_de_pago (
                                                   bi_tipo_medio_pago_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                                   bi_tipo_medio_pago_descripcion VARCHAR(255),
);
GO
CREATE TABLE CHIRIPIORCA.BI_tipo_envio (
                                           bi_tipo_envio_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                           bi_tipo_envio_descripcion VARCHAR(255),
);
GO
CREATE TABLE CHIRIPIORCA.BI_subrubro (
                                         bi_subr_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                         bi_subr_descripcion VARCHAR(255),
                                         bi_subr_rubro_descripcion VARCHAR(255)
);

CREATE TABLE CHIRIPIORCA.BI_marca(
                                     bi_marca_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                     bi_marca_descripcion VARCHAR(255)
);
GO
CREATE TABLE CHIRIPIORCA.BI_concepto_factura (
                                                 bi_conc_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                                 bi_conc_descripcion VARCHAR(255)
);
GO
-- TABLAS DE HECHOS

CREATE TABLE CHIRIPIORCA.BI_HECHO_PUBLICACION (
                                                  bi_publicacion_id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                                  bi_publicacion_tiempo DECIMAL(18, 0),
                                                  bi_publicacion_subRubro DECIMAL(18, 0),
                                                  bi_publicacion_marca DECIMAL(18, 0),
                                                  bi_publicacion_stock DECIMAL(18, 0),
                                                  bi_publicacion_promedio_vigencia DECIMAL(18, 0),
                                                  FOREIGN KEY (bi_publicacion_tiempo) 	REFERENCES CHIRIPIORCA.BI_TIEMPO(bi_tiempo_id),
                                                  FOREIGN KEY (bi_publicacion_subRubro) 	REFERENCES CHIRIPIORCA.BI_SUBRUBRO(bi_subr_id),
                                                  FOREIGN KEY (bi_publicacion_marca) 		REFERENCES CHIRIPIORCA.BI_MARCA(bi_marca_id),
);
GO
CREATE TABLE CHIRIPIORCA.BI_HECHO_EVENTO_LOCALIDAD_CLIENTE (
                                                               bi_evento_loc_cliente_id DECIMAL(18, 0) 			IDENTITY(1,1) PRIMARY KEY,
                                                               bi_evento_loc_cliente_ubicacion DECIMAL(18, 0),
                                                               bi_evento_loc_cliente_tiempo DECIMAL(18, 0),
                                                               bi_evento_loc_cliente_rango_etario DECIMAL(18, 0),
                                                               bi_evento_loc_cliente_subRubro decimal(18,0),
                                                               bi_evento_loc_cliente_importe_ventas decimal(18,2),
                                                               bi_evento_loc_cliente_costo_envio decimal(18,2)
                                                                   FOREIGN KEY (bi_evento_loc_cliente_ubicacion) REFERENCES CHIRIPIORCA.BI_UBICACION(bi_ubic_id),
                                                               FOREIGN KEY (bi_evento_loc_cliente_tiempo) 	REFERENCES CHIRIPIORCA.BI_TIEMPO(bi_tiempo_id),
                                                               FOREIGN KEY (bi_evento_loc_cliente_rango_etario) REFERENCES CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES(bi_rango_etario_id),
                                                               FOREIGN KEY (bi_evento_loc_cliente_subRubro) REFERENCES CHIRIPIORCA.BI_SUBRUBRO(bi_subr_id),
);
GO
CREATE TABLE CHIRIPIORCA.BI_HECHO_PAGO (
                                           bi_pago_id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
                                           bi_pago_tiempo DECIMAL(18,0),
                                           bi_pago_ubicacion DECIMAL(18,0),
                                           bi_pago_tipo_medio_de_pago DECIMAL(18,0),
                                           bi_pago_importe DECIMAL(18,2)
                                               FOREIGN KEY (bi_pago_tiempo) REFERENCES CHIRIPIORCA.BI_TIEMPO(bi_tiempo_id),
                                           FOREIGN KEY (bi_pago_ubicacion) REFERENCES CHIRIPIORCA.BI_UBICACION(bi_ubic_id),
                                           FOREIGN KEY (bi_pago_tipo_medio_de_pago) REFERENCES CHIRIPIORCA.BI_TIPO_MEDIO_DE_PAGO(bi_tipo_medio_pago_id),
);
GO

CREATE TABLE CHIRIPIORCA.BI_HECHO_EVENTO_PROVINCIA_ALMACEN (
                                                               bi_evento_provincia_almacen_id DECIMAL(18, 0) 			IDENTITY(1,1) PRIMARY KEY,
                                                               bi_evento_provincia_almacen_tiempo DECIMAL(18, 0),
                                                               bi_evento_provincia_almacen_ubicacion DECIMAL(18, 0),
                                                               bi_evento_provincia_almacen_importe_venta DECIMAL(18, 2),
                                                               bi_evento_provincia_almacen_envios_cumplidos DECIMAL(18,0),
                                                               bi_evento_provincia_almacen_envios_no_cumplidos DECIMAL(18,0),
                                                               FOREIGN KEY (bi_evento_provincia_almacen_tiempo) REFERENCES CHIRIPIORCA.BI_TIEMPO(bi_tiempo_id),
                                                               FOREIGN KEY (bi_evento_provincia_almacen_ubicacion) REFERENCES CHIRIPIORCA.BI_UBICACION(bi_ubic_id)
);
GO
CREATE TABLE CHIRIPIORCA.BI_HECHO_FACTURACION (
                                                  bi_facturacion_id DECIMAL(18, 0) 			IDENTITY(1,1) PRIMARY KEY,
                                                  bi_facturacion_tiempo DECIMAL(18, 0),
                                                  bi_facturacion_ubicacion DECIMAL(18, 0),
                                                  bi_facturacion_concepto DECIMAL(18,0),
                                                  bi_facturacion_total DECIMAL(18,0),
                                                  FOREIGN KEY (bi_facturacion_tiempo) 			REFERENCES CHIRIPIORCA.BI_TIEMPO(bi_tiempo_id),
                                                  FOREIGN KEY (bi_facturacion_ubicacion) 			REFERENCES CHIRIPIORCA.BI_UBICACION(bi_ubic_id),
                                                  FOREIGN KEY (bi_facturacion_concepto) 			REFERENCES CHIRIPIORCA.BI_CONCEPTO_FACTURA(bi_conc_id)
);
GO



/*
MIGRACION DIMENSIONES
*/
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_TIEMPO AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_TIEMPO (bi_tiempo_anio, bi_tiempo_mes, bi_tiempo_cuatrimestre)
SELECT
    YEAR(fecha) AS bi_tiempo_anio,
    MONTH(fecha) AS bi_tiempo_mes,
    (MONTH(fecha) - 1) / 4 + 1 AS bi_tiempo_cuatrimestre
FROM (
    SELECT p.fecha_publicacion AS fecha
    FROM CHIRIPIORCA.PUBLICACION p
    WHERE p.fecha_publicacion IS NOT NULL
    UNION ALL
    SELECT p.fecha_vencimiento
    FROM CHIRIPIORCA.PUBLICACION p
    WHERE p.fecha_vencimiento IS NOT NULL
    UNION ALL
    SELECT v.fecha_hora
    FROM CHIRIPIORCA.VENTA v
    WHERE v.fecha_hora IS NOT NULL
    UNION ALL
    SELECT e.fecha_hora_de_entrega
    FROM CHIRIPIORCA.ENVIO e
    WHERE e.fecha_hora_de_entrega IS NOT NULL
    UNION ALL
    SELECT e.fecha_programada
    FROM CHIRIPIORCA.ENVIO e
    WHERE e.fecha_programada IS NOT NULL
    UNION ALL
    SELECT p.fecha
    FROM CHIRIPIORCA.PAGO p
    WHERE p.fecha IS NOT NULL
    UNION ALL
    SELECT f.fecha_de_la_factura
    FROM CHIRIPIORCA.FACTURACION f
    WHERE f.fecha_de_la_factura IS NOT NULL
    ) AS fechas
WHERE NOT EXISTS (
    SELECT 1
    FROM CHIRIPIORCA.BI_TIEMPO bt
    WHERE bt.bi_tiempo_anio = YEAR(fechas.fecha)
  AND bt.bi_tiempo_mes = MONTH(fechas.fecha)
  AND bt.bi_tiempo_cuatrimestre = (MONTH(fechas.fecha) - 1) / 4 + 1
    )
GROUP BY
    YEAR(fecha),
    MONTH(fecha),
    (MONTH(fecha) - 1) / 4 + 1;
END;
GO

-- 2
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_UBICACION AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_UBICACION(bi_ubic_provincia, bi_ubic_localidad)
SELECT
    p.nombre_provincia,
    l.nombre_localidad
FROM CHIRIPIORCA.Localidad l
         JOIN CHIRIPIORCA.Provincia p ON p.id = l.id_provincia
WHERE l.id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM CHIRIPIORCA.BI_UBICACION bu
    WHERE bu.bi_ubic_provincia = p.nombre_provincia
      AND bu.bi_ubic_localidad = l.nombre_localidad
)
GROUP BY p.nombre_provincia, l.nombre_localidad;
END;
GO

--3
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_ETARIO_CLIENTES AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES (bi_rango_etario_nombre)
VALUES	('< 25'),
          ('25 - 35'),
          ('35 - 50'),
          ('> 50')
END;
GO

-- 4
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_HORARIO_VENTAS AS
BEGIN
INSERT INTO CHIRIPIORCA.Rango_horario_ventas (bi_rango_horario_nombre)
VALUES ('00:00 - 06:00'),
       ('06:00 - 12:00'),
       ('12:00 - 18:00'),
       ('18:00 - 00:00')

END;
GO

-- 5
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_MEDIO_DE_PAGO AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_tipo_medio_de_pago (bi_tipo_medio_pago_descripcion)
SELECT t.tipo_medio_de_pago
FROM CHIRIPIORCA.Tipo_medio_de_pago t
WHERE t.tipo_medio_de_pago IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM CHIRIPIORCA.BI_tipo_medio_de_pago bt
    WHERE bt.bi_tipo_medio_pago_descripcion = t.tipo_medio_de_pago
)
GROUP BY t.tipo_medio_de_pago;
END;
GO
--6
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_ENVIO AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_tipo_envio (bi_tipo_envio_descripcion)
SELECT t.envio
FROM CHIRIPIORCA.Tipo_Envio t
WHERE t.envio IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM CHIRIPIORCA.BI_tipo_envio bt
    WHERE bt.bi_tipo_envio_descripcion = t.envio
)
GROUP BY t.envio;
END;
GO
--7
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_SUBRUBRO AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_subrubro (bi_subr_descripcion, bi_subr_rubro_descripcion)
SELECT s.nombre_subrubro, r.rubro_descripcion
FROM CHIRIPIORCA.SubRubro s
         JOIN CHIRIPIORCA.Rubro r ON r.rubro_descripcion = s.subrubro_descripcion
WHERE s.id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM CHIRIPIORCA.BI_subrubro bs
    WHERE bs.bi_subr_descripcion = s.nombre_subrubro
      AND bs.bi_subr_rubro_descripcion = r.rubro_descripcion
)
GROUP BY s.nombre_subrubro, r.rubro_descripcion;
END;
GO

-- 8
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_MARCA AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_marca (bi_marca_descripcion)
SELECT m.nombre_marca
FROM CHIRIPIORCA.Marca m
WHERE m.nombre_marca IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM CHIRIPIORCA.BI_marca bm
    WHERE bm.bi_marca_descripcion = m.nombre_marca
)
GROUP BY m.nombre_marca; -- Agrupación para evitar duplicados
END;
GO

-- 9
CREATE PROCEDURE CHIRIPIORCA.MIGRAR_DIMENSION_CONCEPTO_FACTURA AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_concepto_factura (bi_conc_descripcion)
SELECT d.concepto
FROM CHIRIPIORCA.Detalle_de_factura d
WHERE d.id IS NOT NULL
  AND NOT EXISTS (
    SELECT 1
    FROM CHIRIPIORCA.BI_concepto_factura bc
    WHERE bc.bi_conc_descripcion = d.concepto
)
GROUP BY d.concepto; -- Agrupación para garantizar datos únicos sin DISTINCT
END;
GO

EXEC CHIRIPIORCA.MIGRAR_DIMENSION_CONCEPTO_FACTURA;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_MARCA;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_ETARIO_CLIENTES;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_RANGO_HORARIO_VENTAS;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_SUBRUBRO;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_TIEMPO;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_ENVIO;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_TIPO_MEDIO_DE_PAGO;
EXEC CHIRIPIORCA.MIGRAR_DIMENSION_UBICACION;
GO

--Está
CREATE PROCEDURE CHIRIPIORCA.BI_MIGRACION_PUBLICACION AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_HECHO_PUBLICACION(
    bi_publicacion_tiempo,
    bi_publicacion_subRubro,
    bi_publicacion_marca,
    bi_publicacion_stock,
    bi_publicacion_promedio_vigencia
)
SELECT
    bt.bi_tiempo_id,
    bs.bi_subr_id,
    bm.bi_marca_id,
    AVG(CAST(p.stock AS FLOAT)) AS promedio_stock,
    AVG(CASE
            WHEN p.fecha_publicacion IS NOT NULL AND p.fecha_vencimiento IS NOT NULL
                THEN DATEDIFF(DAY, p.fecha_publicacion, p.fecha_vencimiento)
            ELSE NULL
        END) AS promedio_vigencia
FROM CHIRIPIORCA.PUBLICACION p
         JOIN CHIRIPIORCA.PRODUCTO pr ON p.codigo_producto = pr.id
         JOIN CHIRIPIORCA.MARCA m ON pr.nombre_marca = m.nombre_marca
         JOIN CHIRIPIORCA.Subrubro sr ON pr.subrubro = sr.id
         JOIN CHIRIPIORCA.RUBRO r ON sr.subrubro_descripcion = r.rubro_descripcion
         JOIN CHIRIPIORCA.BI_TIEMPO bt ON bt.bi_tiempo_anio = YEAR(p.fecha_publicacion)
    AND bt.bi_tiempo_mes = MONTH(p.fecha_publicacion)
    JOIN CHIRIPIORCA.BI_marca bm ON bm.bi_marca_descripcion = m.nombre_marca
    JOIN CHIRIPIORCA.BI_subrubro bs ON bs.bi_subr_descripcion = sr.nombre_subrubro
    AND bs.bi_subr_rubro_descripcion = r.rubro_descripcion
GROUP BY
    bt.bi_tiempo_id,
    bs.bi_subr_id,
    bm.bi_marca_id;
END;
GO

--Está
CREATE FUNCTION CHIRIPIORCA.OBTENER_ID_RANGO_ETARIO(@fecha_nacimiento DATE) RETURNS DECIMAL(18) AS
BEGIN
	DECLARE @id_rango_edad DECIMAL(18,0);
	DECLARE @HOY DATE;
	DECLARE @EDAD INT;
	SET @HOY = GETDATE();
	SET @EDAD = DATEDIFF(YEAR, @fecha_nacimiento, GETDATE()) - 
                  CASE 
                      WHEN MONTH(@fecha_nacimiento) > MONTH(GETDATE()) OR 
                           (MONTH(@fecha_nacimiento) = MONTH(GETDATE()) AND DAY(@fecha_nacimiento) > DAY(GETDATE()))
                      THEN 1 
                      ELSE 0
END;

	IF @EDAD BETWEEN 0 AND 24
SELECT @id_rango_edad = rec.bi_rango_etario_id
FROM CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES rec
WHERE rec.bi_rango_etario_nombre = '< 25'

    ELSE IF @EDAD BETWEEN 25 AND 35
SELECT @id_rango_edad = rec.bi_rango_etario_id
FROM CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES rec
WHERE rec.bi_rango_etario_nombre = '25 - 35'

    ELSE IF @EDAD BETWEEN 35 AND 50
SELECT @id_rango_edad = bi_rango_etario_id
FROM CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES rec
WHERE rec.bi_rango_etario_nombre = '35 - 50'

    ELSE
SELECT @id_rango_edad = rec.bi_rango_etario_id
FROM CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES rec
WHERE rec.bi_rango_etario_nombre = '> 50'

    RETURN @id_rango_edad;
END
GO

--Hecho
CREATE PROCEDURE CHIRIPIORCA.localidad_cliente AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_HECHO_EVENTO_LOCALIDAD_CLIENTE(
    bi_evento_loc_cliente_tiempo,
    bi_evento_loc_cliente_ubicacion,
    bi_evento_loc_cliente_subRubro,
    bi_evento_loc_cliente_rango_etario,
    bi_evento_loc_cliente_importe_ventas,
    bi_evento_loc_cliente_costo_envio
)
SELECT
    bt.bi_tiempo_id,
    bu.bi_ubic_id,
    bs.bi_subr_id,
    CHIRIPIORCA.OBTENER_ID_RANGO_ETARIO(c.fecha_nacimiento) AS rango_etario,
    SUM(v.Total) AS total_ventas,
    AVG(COALESCE(e.costo_envio, 0)) AS costo_promedio_envio
FROM CHIRIPIORCA.VENTA v
         JOIN CHIRIPIORCA.CLIENTE c ON v.cliente_usuario = c.codigo_cliente
         JOIN CHIRIPIORCA.Cliente_usuario cl on cl.codigo_usuario = c.codigo_cliente
         JOIN CHIRIPIORCA.LOCALIDAD l ON  cl.id_localidad = l.id
         JOIN CHIRIPIORCA.PROVINCIA pv ON l.id_provincia = pv.id
         left JOIN CHIRIPIORCA.Envio e ON e.id_venta = v.cod_venta
         left JOIN CHIRIPIORCA.Detalle_de_venta dv ON dv.id = v.cod_venta
         LEFT JOIN CHIRIPIORCA.PUBLICACION p ON p.id = dv.codigo_de_publicacion
         LEFT JOIN CHIRIPIORCA.PRODUCTO pr ON p.codigo_producto = pr.id
         LEFT JOIN CHIRIPIORCA.Subrubro sr ON pr.subrubro = sr.id
         LEFT JOIN CHIRIPIORCA.RUBRO r ON sr.subrubro_descripcion = r.rubro_descripcion
         LEFT JOIN CHIRIPIORCA.BI_TIEMPO bt ON bt.bi_tiempo_anio = YEAR(v.fecha_hora)
    AND bt.bi_tiempo_mes = MONTH(v.fecha_hora)
    LEFT JOIN CHIRIPIORCA.BI_subrubro bs ON bs.bi_subr_descripcion = sr.nombre_subrubro
    AND bs.bi_subr_rubro_descripcion = r.rubro_descripcion
    JOIN CHIRIPIORCA.BI_UBICACION bu ON bu.bi_ubic_localidad = l.nombre_localidad
    AND bu.bi_ubic_provincia = pv.nombre_provincia
GROUP BY
    bt.bi_tiempo_id,
    bu.bi_ubic_id,
    bs.bi_subr_id,
    CHIRIPIORCA.OBTENER_ID_RANGO_ETARIO(c.fecha_nacimiento);
END;
GO


CREATE PROCEDURE CHIRIPIORCA.MIGRAR_PAGOS
    AS
BEGIN

INSERT INTO CHIRIPIORCA.BI_HECHO_PAGO(bi_pago_tiempo, bi_pago_ubicacion, bi_pago_tipo_medio_de_pago, bi_pago_importe)
SELECT bt.bi_tiempo_id, bu.bi_ubic_id, btipo.bi_tipo_medio_pago_id, p.importe
FROM CHIRIPIORCA.Pago p
         JOIN CHIRIPIORCA.BI_TIEMPO bt on bt.bi_tiempo_mes = MONTH(p.fecha) and bt.bi_tiempo_anio = YEAR(p.fecha)
    JOIN CHIRIPIORCA.Venta v on v.id = p.id_venta
    JOIN CHIRIPIORCA.Cliente cl on cl.codigo_cliente = v.cliente_usuario
    JOIN CHIRIPIORCA.Cliente_usuario us on us.codigo_usuario = cl.codigo_cliente
    JOIN CHIRIPIORCA.Localidad loc on loc.id = us.id_localidad
    JOIN CHIRIPIORCA.Provincia prov on prov.id = loc.id_provincia
    JOIN CHIRIPIORCA.BI_UBICACION bu on bu.bi_ubic_localidad = loc.nombre_localidad and bu.bi_ubic_provincia = prov.nombre_provincia
    JOIN CHIRIPIORCA.Medio_de_pago med on med.id_pago = p.id_medio_pago
    JOIN CHIRIPIORCA.Tipo_medio_de_pago tp on tp.tipo_medio_de_pago = med.tipo_medio
    JOIN CHIRIPIORCA.BI_tipo_medio_de_pago btipo on btipo.bi_tipo_medio_pago_descripcion = tp.tipo_medio_de_pago
END
GO


CREATE PROCEDURE CHIRIPIORCA.MIGRAR_FACTURACION
    AS
BEGIN
    -- Insertar datos resumidos en la tabla de hechos
INSERT INTO CHIRIPIORCA.BI_HECHO_FACTURACION (
    bi_facturacion_tiempo,
    bi_facturacion_ubicacion,
    bi_facturacion_concepto,
    bi_facturacion_total
)
SELECT
    bt.bi_tiempo_id,                -- ID de la dimensión de tiempo
    bu.bi_ubic_id,                 -- ID de la dimensión de ubicación
    bc.bi_conc_id,                 -- ID de la dimensión de concepto
    SUM(f.importe_total) AS total_facturacion  -- Total facturado
FROM
    CHIRIPIORCA.Facturacion f
        JOIN
    CHIRIPIORCA.Detalle_de_factura det
    ON f.detalle_factura = det.id
        JOIN
    CHIRIPIORCA.BI_concepto_factura bc
    ON bc.bi_conc_descripcion = det.concepto
        JOIN
    CHIRIPIORCA.Vendedor v
    ON f.vendedor = v.cuit
        JOIN
    CHIRIPIORCA.Vendedor_usuario us
    ON us.nombre = v.usuario
        JOIN
    CHIRIPIORCA.Localidad l
    ON us.id_localidad = l.id
        JOIN
    CHIRIPIORCA.Provincia pv
    ON l.id_provincia = pv.id
        JOIN
    CHIRIPIORCA.BI_UBICACION bu
    ON bu.bi_ubic_localidad = l.nombre_localidad
        AND bu.bi_ubic_provincia = pv.nombre_provincia
        JOIN
    CHIRIPIORCA.BI_TIEMPO bt
    ON bt.bi_tiempo_anio = YEAR(f.fecha_de_la_factura)
    AND bt.bi_tiempo_mes = MONTH(f.fecha_de_la_factura)
GROUP BY
    bt.bi_tiempo_id,
    bu.bi_ubic_id,
    bc.bi_conc_id;
END;
GO


CREATE PROCEDURE CHIRIPIORCA.evento_provincia_envio AS
BEGIN
INSERT INTO CHIRIPIORCA.BI_HECHO_EVENTO_PROVINCIA_ALMACEN(bi_evento_provincia_almacen_tiempo ,
                                                          bi_evento_provincia_almacen_ubicacion,
                                                          bi_evento_provincia_almacen_importe_venta,
                                                          bi_evento_provincia_almacen_envios_cumplidos,
                                                          bi_evento_provincia_almacen_envios_no_cumplidos)
SELECT
    bt.bi_tiempo_id,
    bu.bi_ubic_id,
    AVG(v.Total),
    SUM(CASE WHEN (e.horario_de_fin - e.horario_de_inicio) > 0 THEN 1 ELSE 0 END),
    SUM(CASE WHEN (e.horario_de_fin - e.horario_de_inicio) < 0 THEN 1 ELSE 0 END)
from CHIRIPIORCA.ENVIO e
         JOIN CHIRIPIORCA.VENTA v on e.id_venta = v.id
         join CHIRIPIORCA.Detalle_de_venta dv on dv.id = v.detalle_venta
         join CHIRIPIORCA.PUBLICACION p on p.id = dv.codigo_de_publicacion
         join CHIRIPIORCA.ALMACEN a on p.almacen = a.id_almacen
         join CHIRIPIORCA.LOCALIDAD l on a.id_localidad = l.id
         join CHIRIPIORCA.PROVINCIA pv on l.id_provincia = pv.id
         join CHIRIPIORCA.BI_UBICACION bu on bu.bi_ubic_localidad = l.nombre_localidad and bu.bi_ubic_provincia = pv.nombre_provincia -- para arreglar
         join CHIRIPIORCA.BI_TIEMPO bt on bt.bi_tiempo_anio = YEAR(e.fecha_hora_de_entrega) and bt.bi_tiempo_mes = MONTH(e.fecha_hora_de_entrega)
group by YEAR(e.fecha_hora_de_entrega), MONTH(e.fecha_hora_de_entrega),
    l.nombre_localidad, pv.nombre_provincia, bt.bi_tiempo_id, bu.bi_ubic_id
END
GO



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------(7)EXEC HECHOS------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

EXEC CHIRIPIORCA.migrar_facturacion;
EXEC CHIRIPIORCA.BI_MIGRACION_PUBLICACION;
EXEC CHIRIPIORCA.evento_provincia_envio;
EXEC CHIRIPIORCA.localidad_cliente;
EXEC CHIRIPIORCA.MIGRAR_PAGOS;
GO

SELECT COUNT (*) as HECHO_EVENTO_LOCALIDAD_CLIENTE FROM CHIRIPIORCA.BI_HECHO_EVENTO_LOCALIDAD_CLIENTE
SELECT COUNT (*) as HECHO_EVENTO_PROVINCIA_ALMACEN FROM CHIRIPIORCA.BI_HECHO_EVENTO_PROVINCIA_ALMACEN
SELECT COUNT (*) as BI_HECHO_FACTURACION  FROM  CHIRIPIORCA.BI_HECHO_FACTURACION
SELECT COUNT (*) as BI_HECHO_PAGO FROM  CHIRIPIORCA.BI_HECHO_PAGO
SELECT COUNT (*) as BI_MIGRACION_PUBLICACION FROM CHIRIPIORCA.BI_HECHO_PUBLICACION
    GO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------(8)VISTAS------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1
CREATE VIEW CHIRIPIORCA.PROM_TIEMPO_PUBLICACIONES_VW AS
SELECT
    bt.bi_tiempo_anio AS [año],
		bt.bi_tiempo_cuatrimestre AS cuatrimestre,
		bs.bi_subr_rubro_descripcion AS RUBRO,
		bs.bi_subr_descripcion AS SUB_RUBRO,
		AVG(hecho_public.bi_publicacion_promedio_vigencia) AS [promedio de vigencia en dias]
	FROM CHIRIPIORCA.BI_HECHO_PUBLICACION hecho_public
	JOIN CHIRIPIORCA.BI_TIEMPO bt ON bt.bi_tiempo_id = hecho_public.bi_publicacion_tiempo
	JOIN CHIRIPIORCA.BI_SUBRUBRO bs ON bs.bi_subr_id = hecho_public.bi_publicacion_subRubro 

	GROUP BY bt.bi_tiempo_anio, bt.bi_tiempo_cuatrimestre, bs.bi_subr_rubro_descripcion,bs.bi_subr_descripcion
GO

-- 2
CREATE VIEW CHIRIPIORCA.PROMEDIO_STOCK_INICIAL_VW AS
SELECT
    bt.bi_tiempo_anio AS [Año],
		bm.bi_marca_descripcion AS [Marca_Descripcion],
		AVG(hecho_public.bi_publicacion_stock) AS [promedio de stock inicial]
	FROM CHIRIPIORCA.BI_HECHO_PUBLICACION hecho_public
	JOIN CHIRIPIORCA.BI_MARCA bm ON bm.bi_marca_id = hecho_public.bi_publicacion_marca

	JOIN CHIRIPIORCA.BI_TIEMPO bt ON bt.bi_tiempo_id = hecho_public.bi_publicacion_tiempo
	
	GROUP BY bm.bi_marca_descripcion, bt.bi_tiempo_anio 
	GO

-- 3
CREATE VIEW CHIRIPIORCA.VENTA_PROMEDIO_MENSUAL_VW AS
SELECT
    bt.bi_tiempo_anio as [Año],
		bt.bi_tiempo_mes as [Mes],
		bu.bi_ubic_provincia as [Provincia],
		AVG(hecho_almacen.bi_evento_provincia_almacen_importe_venta) as [prom importes en ventas mensual]
	FROM CHIRIPIORCA.BI_HECHO_EVENTO_PROVINCIA_ALMACEN hecho_almacen
	JOIN CHIRIPIORCA.BI_TIEMPO bt ON bt.bi_tiempo_id = hecho_almacen.bi_evento_provincia_almacen_tiempo
	JOIN CHIRIPIORCA.BI_UBICACION bu ON bu.bi_ubic_id = hecho_almacen.bi_evento_provincia_almacen_ubicacion
	GROUP BY bt.bi_tiempo_anio,bt.bi_tiempo_mes,bu.bi_ubic_provincia
GO

-- 4
CREATE VIEW CHIRIPIORCA.MEJORES_CINCO_RUBROS_VW AS
SELECT
        [Cuatrimestre],
        [Año],
        [Localidad],
        [Rango Etario],
        [Rubro],
        [TotalVentas]
        FROM (
        SELECT
        bt.bi_tiempo_cuatrimestre AS Cuatrimestre,
        bt.bi_tiempo_anio AS [Año],
        bu.bi_ubic_localidad AS [Localidad],
        br.bi_rango_etario_nombre AS [Rango Etario],
        bs.bi_subr_rubro_descripcion AS [Rubro],
        SUM(hecho.bi_evento_loc_cliente_importe_ventas) AS TotalVentas,
        ROW_NUMBER() OVER (
        PARTITION BY
        bt.bi_tiempo_anio,
        bt.bi_tiempo_cuatrimestre,
        bu.bi_ubic_localidad,
        br.bi_rango_etario_nombre
        ORDER BY
        SUM(hecho.bi_evento_loc_cliente_importe_ventas) DESC
        ) AS RankRubro
        FROM CHIRIPIORCA.BI_HECHO_EVENTO_LOCALIDAD_CLIENTE hecho
        JOIN CHIRIPIORCA.BI_TIEMPO bt ON bt.bi_tiempo_id = hecho.bi_evento_loc_cliente_tiempo
        JOIN CHIRIPIORCA.BI_UBICACION bu ON bu.bi_ubic_id = hecho.bi_evento_loc_cliente_ubicacion
        JOIN CHIRIPIORCA.BI_RANGO_ETARIO_CLIENTES br ON br.bi_rango_etario_id = hecho.bi_evento_loc_cliente_rango_etario
        JOIN CHIRIPIORCA.BI_SUBRUBRO bs ON bs.bi_subr_id = hecho.bi_evento_loc_cliente_subRubro
        GROUP BY
        bt.bi_tiempo_anio,
        bt.bi_tiempo_cuatrimestre,
        bu.bi_ubic_localidad,
        br.bi_rango_etario_nombre,
        bs.bi_subr_rubro_descripcion
        ) AS RubrosRankeados
        WHERE RankRubro <= 5
        GO


-- 6
CREATE VIEW CHIRIPIORCA.MEJORES_TRES_LOCALIDADES_VW AS
SELECT
        [Año],
        [Mes],
        [Medio de Pago],
        [Localidad],
        [Importe]
        FROM (
        SELECT
        bt.bi_tiempo_anio AS [Año],
        bt.bi_tiempo_mes AS Mes,
        btp.bi_tipo_medio_pago_descripcion AS [Medio de Pago],
        bu.bi_ubic_localidad AS [Localidad],
        SUM(hecho.bi_pago_importe) AS [Importe],
        ROW_NUMBER() OVER (
        PARTITION BY
        bt.bi_tiempo_anio,
        bt.bi_tiempo_mes,
        bi_tipo_medio_pago_descripcion
        ORDER BY
        SUM(hecho.bi_pago_importe) DESC
        ) AS RankLocalidad
        FROM CHIRIPIORCA.BI_HECHO_PAGO hecho
        JOIN CHIRIPIORCA.BI_TIEMPO bt
        ON bt.bi_tiempo_id = hecho.bi_pago_tiempo
        JOIN CHIRIPIORCA.BI_TIPO_MEDIO_DE_PAGO btp
        ON btp.bi_tipo_medio_pago_id = hecho.bi_pago_tipo_medio_de_pago
        JOIN CHIRIPIORCA.BI_UBICACION bu
        ON bu.bi_ubic_id = hecho.bi_pago_ubicacion
        GROUP BY
        bt.bi_tiempo_anio,
        bt.bi_tiempo_mes,
        btp.bi_tipo_medio_pago_descripcion,
        bu.bi_ubic_localidad,
        btp.bi_tipo_medio_pago_descripcion,
        bt.bi_tiempo_mes,
        bt.bi_tiempo_anio
        ) AS LocalidadesRankeadas
        WHERE RankLocalidad <= 3
        GO

-- 7
CREATE VIEW CHIRIPIORCA.PORCENTAJE_DE_CUMPLIMIENTO_DE_ENVIOS AS
SELECT
    bt.bi_tiempo_anio as [Año],
		bt.bi_tiempo_mes as [Mes],
		bu.bi_ubic_provincia as [Provincia],
		(SUM(hecho.bi_evento_provincia_almacen_envios_cumplidos) *100 / (SUM(hecho.bi_evento_provincia_almacen_envios_cumplidos)))
		+ SUM(hecho.bi_evento_provincia_almacen_envios_no_cumplidos) as [Porcentaje Cumplimiento de Envios]
        FROM CHIRIPIORCA.BI_HECHO_EVENTO_PROVINCIA_ALMACEN hecho
		JOIN CHIRIPIORCA.BI_TIEMPO bt ON bt.bi_tiempo_id = hecho.bi_evento_provincia_almacen_tiempo
		JOIN CHIRIPIORCA.BI_UBICACION bu ON bu.bi_ubic_id = hecho.bi_evento_provincia_almacen_ubicacion
		GROUP BY bt.bi_tiempo_anio, bt.bi_tiempo_mes, bu.bi_ubic_provincia
GO

-- 8 
CREATE VIEW CHIRIPIORCA.LAS_CINCO_LOCALIDADES_MAYOR_COSTO_ENVIO AS
SELECT TOP 5
	bu.bi_ubic_provincia as Provincia,
        AVG(hecho.bi_evento_loc_cliente_costo_envio) as [Promedio de Costo de Envio]
	FROM CHIRIPIORCA.BI_HECHO_EVENTO_LOCALIDAD_CLIENTE hecho
	JOIN CHIRIPIORCA.BI_UBICACION bu on bu.bi_ubic_id = hecho.bi_evento_loc_cliente_ubicacion

	GROUP BY bu.bi_ubic_provincia
	ORDER BY [Promedio de Costo de Envio] desc
GO

-- 9
CREATE VIEW CHIRIPIORCA.PORCENTAJE_FACTURACION_X_CONCEPTO AS
SELECT
    bt.bi_tiempo_mes as Mes,
    bt.bi_tiempo_anio as [Año],
	bc.bi_conc_descripcion as [Concepto Factura],
	sum(hecho.bi_facturacion_total)*100
	/
	(SELECT SUM(hecho.bi_facturacion_total)
	FROM CHIRIPIORCA.BI_HECHO_FACTURACION hecho
	join CHIRIPIORCA.BI_TIEMPO bt2 on hecho.bi_facturacion_tiempo = bt2.bi_tiempo_id
	where bt2.bi_tiempo_mes = bt.bi_tiempo_mes 
	and bt2.bi_tiempo_anio = bt.bi_tiempo_anio) as [Porcentaje Facturado]

	FROM CHIRIPIORCA.BI_HECHO_FACTURACION hecho
	join CHIRIPIORCA.BI_TIEMPO bt on hecho.bi_facturacion_tiempo = bt.bi_tiempo_id
	join CHIRIPIORCA.BI_CONCEPTO_FACTURA bc on hecho.bi_facturacion_concepto = bc.bi_conc_id
	group by bt.bi_tiempo_mes, bt.bi_tiempo_anio, bc.bi_conc_descripcion
GO

-- 10
CREATE VIEW CHIRIPIORCA.FACTURACION_X_PROVINCIA AS
SELECT
    bt.bi_tiempo_cuatrimestre as Cuatrimestre,
    bt.bi_tiempo_anio as [Año],
	bu.bi_ubic_provincia as Provincia,
	SUM(hecho.bi_facturacion_total)  as [Total Facturado]
	FROM CHIRIPIORCA.BI_HECHO_FACTURACION hecho
	join CHIRIPIORCA.BI_UBICACION bu on hecho.bi_facturacion_ubicacion = bu.bi_ubic_id
	join CHIRIPIORCA.BI_TIEMPO bt on hecho.bi_facturacion_tiempo = bt.bi_tiempo_id
	group by bt.bi_tiempo_cuatrimestre, bt.bi_tiempo_anio, bu.bi_ubic_provincia
GO


SELECT * FROM CHIRIPIORCA.MEJORES_CINCO_RUBROS_VW
SELECT * FROM CHIRIPIORCA.MEJORES_TRES_LOCALIDADES_VW
SELECT * FROM CHIRIPIORCA.PROM_TIEMPO_PUBLICACIONES_VW
SELECT * FROM CHIRIPIORCA.PROMEDIO_STOCK_INICIAL_VW
SELECT * FROM CHIRIPIORCA.VENTA_PROMEDIO_MENSUAL_VW
SELECT * FROM CHIRIPIORCA.FACTURACION_X_PROVINCIA
SELECT * FROM CHIRIPIORCA.LAS_CINCO_LOCALIDADES_MAYOR_COSTO_ENVIO
SELECT * FROM CHIRIPIORCA.PORCENTAJE_DE_CUMPLIMIENTO_DE_ENVIOS
SELECT * FROM CHIRIPIORCA.PORCENTAJE_FACTURACION_X_CONCEPTO
