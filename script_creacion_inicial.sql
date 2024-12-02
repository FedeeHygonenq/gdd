USE GD2C2024
GO



IF OBJECT_ID(N'CHIRIPIORCA.Envio', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Envio;
IF OBJECT_ID(N'CHIRIPIORCA.Pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Pago;
IF OBJECT_ID(N'CHIRIPIORCA.Venta', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Venta;
IF OBJECT_ID(N'CHIRIPIORCA.Detalle_de_venta', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Detalle_de_venta;
IF OBJECT_ID(N'CHIRIPIORCA.Facturacion', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Facturacion;
IF OBJECT_ID(N'CHIRIPIORCA.Detalle_de_factura', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Detalle_de_factura;
IF OBJECT_ID(N'CHIRIPIORCA.Tipo_detalle_factura', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Tipo_detalle_factura;
IF OBJECT_ID(N'CHIRIPIORCA.Cliente_usuario', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Cliente_usuario;
IF OBJECT_ID(N'CHIRIPIORCA.Publicacion', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Publicacion;
IF OBJECT_ID(N'CHIRIPIORCA.Vendedor_usuario', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Vendedor_usuario;
IF OBJECT_ID(N'CHIRIPIORCA.Vendedor', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Vendedor;
IF OBJECT_ID(N'CHIRIPIORCA.Cliente', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Cliente;
IF OBJECT_ID(N'CHIRIPIORCA.Producto', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Producto;
IF OBJECT_ID(N'CHIRIPIORCA.Subrubro', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Subrubro;
IF OBJECT_ID(N'CHIRIPIORCA.Marca', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Marca;
IF OBJECT_ID(N'CHIRIPIORCA.Medio_de_pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Medio_de_pago;
IF OBJECT_ID(N'CHIRIPIORCA.Tipo_medio_de_pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Tipo_medio_de_pago;
IF OBJECT_ID(N'CHIRIPIORCA.Rubro', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Rubro;
IF OBJECT_ID(N'CHIRIPIORCA.Modelo', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Modelo;
IF OBJECT_ID(N'CHIRIPIORCA.Tipo_envio', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Tipo_envio;
IF OBJECT_ID(N'CHIRIPIORCA.Almacen', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Almacen;
IF OBJECT_ID(N'CHIRIPIORCA.Localidad', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Localidad;
IF OBJECT_ID(N'CHIRIPIORCA.Provincia', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Provincia;

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

IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'CHIRIPIORCA') DROP SCHEMA CHIRIPIORCA;
GO
CREATE SCHEMA CHIRIPIORCA;
GO


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------CREACION DE ESQUEMA Y TABLAS------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE CHIRIPIORCA.Cliente (
                                     codigo_cliente DECIMAL(18, 0) IDENTITY(1, 1) PRIMARY KEY,
                                     dni  DECIMAL(18, 0) NOT NULL,
                                     mail NVARCHAR(50) NOT NULL,
                                     nombre NVARCHAR(50) NOT NULL,
                                     apellido NVARCHAR(50) NOT NULL,
                                     fecha_nacimiento DATE NOT NULL
);
GO

CREATE TABLE CHIRIPIORCA.Tipo_medio_de_pago (
                                                tipo_medio_de_pago NVARCHAR(50) PRIMARY KEY
);
GO

CREATE TABLE CHIRIPIORCA.Modelo(
                                   modelo_cod DECIMAL(18, 0) PRIMARY KEY not null,
                                   modelo_descripcion NVARCHAR(50) not null
);
GO
CREATE TABLE CHIRIPIORCA.Provincia(
            id decimal(18,0) primary key IDENTITY(1,1),
            nombre_provincia VARCHAR(30) not NULL
)
CREATE TABLE CHIRIPIORCA.Localidad(
            id decimal(18,0) primary key IDENTITY(1,1),
            nombre_localidad VARCHAR(50) not null,
            id_provincia decimal(18,0) not null,
            FOREIGN KEY (id_provincia) REFERENCES CHIRIPIORCA.Provincia(id)
)

CREATE TABLE CHIRIPIORCA.Rubro(
                                  rubro_descripcion NVARCHAR(50) PRIMARY KEY not null
);
GO

CREATE TABLE CHIRIPIORCA.Medio_de_pago(
                                          id_pago NVARCHAR(50) PRIMARY KEY NOT NULL,
                                          tipo_medio NVARCHAR(50) NOT NULL,
                                          FOREIGN KEY (tipo_medio) REFERENCES CHIRIPIORCA.Tipo_medio_de_pago(tipo_medio_de_pago)
);
GO

CREATE TABLE CHIRIPIORCA.Marca (
                                   nombre_marca NVARCHAR(50) PRIMARY KEY not null
);
GO

CREATE TABLE CHIRIPIORCA.Subrubro (
                                      id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
                                      nombre_subrubro NVARCHAR(50) not null,
                                      subrubro_descripcion NVARCHAR(50) not null,
                                      FOREIGN KEY (subrubro_descripcion) REFERENCES CHIRIPIORCA.Rubro(rubro_descripcion)
);
GO

CREATE TABLE CHIRIPIORCA.Producto (
                                      id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY not null,
                                      codigo_de_producto NVARCHAR(50) not null,
                                      descripcion NVARCHAR(50) not null,
                                      subrubro DECIMAL(18,0),
                                      nombre_marca NVARCHAR(50),
                                      precio DECIMAL(18, 0) NOT NULL DEFAULT 0,
                                      modelo_cod DECIMAL(18, 0),
                                      FOREIGN KEY (modelo_cod) REFERENCES CHIRIPIORCA.Modelo(modelo_cod),
                                      FOREIGN KEY (subrubro) REFERENCES CHIRIPIORCA.Subrubro(id),
                                      FOREIGN KEY (nombre_marca) REFERENCES CHIRIPIORCA.Marca(nombre_marca)
);
GO

CREATE TABLE CHIRIPIORCA.Almacen(
                                    id_almacen DECIMAL(18, 0) PRIMARY KEY not null,
                                    calle VARCHAR(50) not null,
                                    numero_calle DECIMAL(18, 0) not null,
                                    costo_al_dia DECIMAL(18, 0) not null,
                                    id_localidad DECIMAL(18,0) not null,
									FOREIGN KEY (id_localidad) REFERENCES CHIRIPIORCA.Localidad(id)
);
GO

CREATE TABLE CHIRIPIORCA.Vendedor (
                                      cuit NVARCHAR(50) PRIMARY KEY not null,
                                      razon_social NVARCHAR(50) not null,
                                      mail NVARCHAR(50) not null,
                                      usuario NVARCHAR(50)
);
GO

CREATE TABLE CHIRIPIORCA.Vendedor_usuario(
                                             nombre NVARCHAR(50) PRIMARY KEY,
                                             usuario_contrasenia NVARCHAR(50) not null,
                                             fecha_creacion DATE not null,
                                             nro_calle DECIMAL(18, 0) not null,
                                             calle NVARCHAR(50) not null,
                                             piso_depto NVARCHAR(50) not null,
                                             cod_postal NVARCHAR(50) not null,
                                             depto NVARCHAR(50) not null,
                                             id_localidad decimal(18,0) not null,
                                             cod_cliente DECIMAL(18,0),
                                             cod_vendedor NVARCHAR(50),
                                             FOREIGN KEY (cod_cliente) REFERENCES CHIRIPIORCA.Cliente(codigo_cliente),
                                             FOREIGN KEY (cod_vendedor) REFERENCES CHIRIPIORCA.Vendedor(cuit),
                                             FOREIGN KEY (id_localidad) REFERENCES CHIRIPIORCA.Localidad(id)
);
GO

CREATE TABLE CHIRIPIORCA.Publicacion(
										 id DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
                                         codigo_de_publicacion DECIMAL(18, 0),
                                         codigo_producto DECIMAL(18, 0),
                                         descripcion NVARCHAR(50) not null,
                                         fecha_publicacion DATE not null,
                                         fecha_vencimiento DATE not null,
                                         stock DECIMAL(18, 0) not null,
                                         precio DECIMAL(18, 0) not null,
                                         costo_de_publicacion DECIMAL(18, 0) not null,
                                         porcentaje_por_venta DECIMAL(18, 0) not null,
                                         almacen DECIMAL(18, 0),
                                         vendedor NVARCHAR(50),
                                         FOREIGN KEY (codigo_producto) REFERENCES CHIRIPIORCA.Producto (id),
                                         FOREIGN KEY (almacen) REFERENCES CHIRIPIORCA.Almacen(id_almacen),
                                         FOREIGN KEY (vendedor) REFERENCES CHIRIPIORCA.Vendedor(cuit)
);
GO

CREATE TABLE CHIRIPIORCA.Tipo_detalle_factura (
                                                  detalle_factura NVARCHAR(50) PRIMARY KEY
);
GO

CREATE TABLE CHIRIPIORCA.Detalle_de_factura (
                                                id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                                publicacion DECIMAL(18, 0) NOT NULL,
                                                concepto VARCHAR(50) NULL,
                                                cantidad DECIMAL(18, 0)NOT NULL,
                                                subtotal DECIMAL(18, 0)  NULL,
                                                precio DECIMAL(18, 0)  NULL,
                                                detalle_factura NVARCHAR(50) NOT NULL,
                                                id_cliente DECIMAL(18, 0) NULL,
                                                FOREIGN KEY (publicacion) REFERENCES CHIRIPIORCA.Publicacion(id),
                                                FOREIGN KEY (detalle_factura) REFERENCES CHIRIPIORCA.Tipo_detalle_factura(detalle_factura),
                                                FOREIGN KEY (id_cliente) REFERENCES CHIRIPIORCA.Cliente(codigo_cliente)
);
GO

CREATE TABLE CHIRIPIORCA.Cliente_usuario(
                                            codigo_usuario DECIMAL(18,0) IDENTITY(1, 1)  PRIMARY KEY,
                                            nombre NVARCHAR(50) not null,
                                            usuario_contrasenia NVARCHAR(50) not null,
                                            fecha_creacion DATE not null,
                                            nro_calle DECIMAL(18, 0) not null,
                                            calle NVARCHAR(50) not null,
                                            piso_depto NVARCHAR(50) not null,
                                            cod_postal NVARCHAR(50) not null,
                                            depto NVARCHAR(50) not null,
                                            id_localidad DECIMAL(18,0) not null,
                                            cod_cliente DECIMAL(18,0),
                                            FOREIGN KEY (cod_cliente) REFERENCES CHIRIPIORCA.Cliente(codigo_cliente),
                                            FOREIGN KEY (id_localidad) REFERENCES CHIRIPIORCA.Localidad(id)

);
GO

CREATE TABLE CHIRIPIORCA.Facturacion (
                                         id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
                                         numero_de_factura DECIMAL(18, 0),
                                         detalle_factura DECIMAL(18, 0),
                                         fecha_de_la_factura DATE NOT NULL,
                                         importe_total DECIMAL(18, 0) NOT NULL,
                                         vendedor NVARCHAR(50),
                                         FOREIGN KEY (detalle_factura) REFERENCES CHIRIPIORCA.Detalle_de_factura(id),
                                         FOREIGN KEY (vendedor) REFERENCES CHIRIPIORCA.Vendedor(cuit)
);
GO

CREATE TABLE CHIRIPIORCA.Detalle_de_venta (
                                              id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY not null,
                                              precio DECIMAL(18, 0) NULL,
                                              cantidad DECIMAL(18, 0) NULL,
                                              subtotal DECIMAL(18, 0) NULL DEFAULT 0,
                                              codigo_de_publicacion DECIMAL(18, 0),
                                              FOREIGN KEY (codigo_de_publicacion) REFERENCES CHIRIPIORCA.Publicacion(id)
);
GO

CREATE TABLE CHIRIPIORCA.Venta (
                                   id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                   cod_venta DECIMAL(18, 0) not null,
                                   cliente_usuario DECIMAL(18,0) NULL,
                                   fecha_hora DATE not null,
                                   detalle_venta DECIMAL(18, 0),
                                   Total DECIMAL(18, 0) not null,
                                   FOREIGN KEY (cliente_usuario) REFERENCES CHIRIPIORCA.Cliente_usuario(codigo_usuario),
                                   FOREIGN KEY (detalle_venta) REFERENCES CHIRIPIORCA.Detalle_de_venta(id)
);
GO

CREATE TABLE CHIRIPIORCA.Tipo_envio(
                                       envio VARCHAR(30) PRIMARY KEY
);
GO

CREATE TABLE CHIRIPIORCA.Envio (
                                   numero_de_envio DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                   id_venta DECIMAL(18, 0),
                                   fecha_programada DATE not null,
                                   horario_de_inicio DECIMAL(18,0) not null,
                                   horario_de_fin DECIMAL(18, 0) not null,
                                   costo_envio DECIMAL(18, 0) not null,
                                   fecha_hora_de_entrega DATE not null,
                                   tipo_de_envio VARCHAR(30) not null,
                                   FOREIGN KEY (tipo_de_envio) REFERENCES CHIRIPIORCA.Tipo_envio(envio),
                                   FOREIGN KEY (id_venta) REFERENCES CHIRIPIORCA.Venta(id)
);
GO

CREATE TABLE CHIRIPIORCA.Pago (
                                  numero_de_pago DECIMAL(18, 0) IDENTITY(1,1)  PRIMARY KEY not null,
                                  id_venta DECIMAL(18, 0),
                                  fecha DATE not null,
                                  id_medio_pago NVARCHAR(50),
                                  importe DECIMAL(18, 0) not null,
                                  nro_tarjeta NVARCHAR(50) not null,
                                  fecha_de_vencimiento_tarjeta DATE not null,
                                  cantidad_cuotas DECIMAL(18, 0) not null,
                                  FOREIGN KEY (id_venta) REFERENCES CHIRIPIORCA.Venta(id),
                                  FOREIGN KEY (id_medio_pago) REFERENCES CHIRIPIORCA.Medio_de_pago(id_pago)
);
GO

INSERT INTO CHIRIPIORCA.Provincia(nombre_provincia)
SELECT DISTINCT ALMACEN_PROVINCIA
FROM gd_esquema.Maestra
WHERE ALMACEN_PROVINCIA IS NOT NULL
UNION
SELECT DISTINCT CLI_USUARIO_DOMICILIO_PROVINCIA
FROM gd_esquema.Maestra
WHERE CLI_USUARIO_DOMICILIO_PROVINCIA IS NOT NULL
UNION
SELECT DISTINCT VEN_USUARIO_DOMICILIO_PROVINCIA
FROM gd_esquema.Maestra
WHERE VEN_USUARIO_DOMICILIO_PROVINCIA IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Localidad(nombre_localidad, id_provincia)
SELECT DISTINCT
    m.ALMACEN_Localidad AS nombre_localidad,
    p.id AS id_provincia
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Provincia p ON p.nombre_provincia = m.ALMACEN_PROVINCIA
WHERE m.ALMACEN_Localidad IS NOT NULL
UNION
SELECT DISTINCT
    m.CLI_USUARIO_DOMICILIO_LOCALIDAD AS nombre_localidad,
    p.id AS id_provincia
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Provincia p ON p.nombre_provincia = m.CLI_USUARIO_DOMICILIO_PROVINCIA
WHERE m.CLI_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL
UNION
SELECT DISTINCT
    m.VEN_USUARIO_DOMICILIO_LOCALIDAD AS nombre_localidad,
    p.id AS id_provincia
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Provincia p ON p.nombre_provincia = m.VEN_USUARIO_DOMICILIO_PROVINCIA
WHERE m.VEN_USUARIO_DOMICILIO_LOCALIDAD IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Tipo_detalle_factura (detalle_factura)
SELECT DISTINCT m.FACTURA_DET_TIPO
FROM gd_esquema.Maestra m
WHERE m.FACTURA_DET_TIPO IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Modelo (modelo_cod, modelo_descripcion)
SELECT DISTINCT PRODUCTO_MOD_CODIGO, PRODUCTO_MOD_DESCRIPCION FROM gd_esquema.Maestra
WHERE PRODUCTO_MOD_CODIGO IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Marca (nombre_marca)
SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra
WHERE PRODUCTO_MARCA IS NOT NULL;
GO


INSERT INTO CHIRIPIORCA.Rubro (rubro_descripcion)
SELECT DISTINCT PRODUCTO_RUBRO_DESCRIPCION FROM gd_esquema.Maestra
WHERE PRODUCTO_RUBRO_DESCRIPCION IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Tipo_medio_de_pago (tipo_medio_de_pago)
SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO FROM gd_esquema.Maestra
WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Tipo_envio (envio)
SELECT DISTINCT ENVIO_TIPO FROM gd_esquema.Maestra
WHERE ENVIO_TIPO IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Almacen(id_almacen,
                                calle,
                                numero_calle,
                                costo_al_dia,
                                id_localidad)
SELECT DISTINCT     ALMACEN_CODIGO,
                    ALMACEN_CALLE,
                    ALMACEN_NRO_CALLE,
                    ALMACEN_COSTO_DIA_AL,
					l.id
                    FROM gd_esquema.Maestra m 
					join CHIRIPIORCA.Localidad l on l.nombre_localidad  = ALMACEN_Localidad 
					join CHIRIPIORCA.Provincia p on p.nombre_provincia  = ALMACEN_Provincia and l.id_provincia = p.id
WHERE ALMACEN_CODIGO IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Cliente(dni, nombre, apellido, fecha_nacimiento, mail)
SELECT DISTINCT     CLIENTE_DNI,
                    CLIENTE_NOMBRE,
                    CLIENTE_APELLIDO,
                    CLIENTE_FECHA_NAC,
                    CLIENTE_MAIL
                    FROM gd_esquema.Maestra
WHERE CLIENTE_DNI IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Cliente_usuario(nombre,
                                         usuario_contrasenia,
                                         fecha_creacion,
                                         calle,
                                         nro_calle,
                                         piso_depto,
                                         cod_postal,
                                         depto,
                                         id_localidad,
                                         cod_cliente)

SELECT DISTINCT     CLI_USUARIO_NOMBRE,
                    CLI_USUARIO_PASS,
                    CLI_USUARIO_FECHA_CREACION,
                    CLI_USUARIO_DOMICILIO_CALLE,
                    CLI_USUARIO_DOMICILIO_NRO_CALLE,
                    CLI_USUARIO_DOMICILIO_PISO,
                    CLI_USUARIO_DOMICILIO_DEPTO,
                    CLI_USUARIO_DOMICILIO_CP,
                    l.id,
                    C.codigo_cliente
                    FROM gd_esquema.Maestra m
    JOIN CHIRIPIORCA.Cliente C on C.dni = m.CLIENTE_DNI and C.nombre = m.CLIENTE_NOMBRE and C.apellido = m.CLIENTE_APELLIDO
    JOIN CHIRIPIORCA.Localidad l on l.nombre_localidad = CLI_USUARIO_DOMICILIO_LOCALIDAD
    JOIN CHIRIPIORCA.Provincia p on p.nombre_provincia = CLI_USUARIO_DOMICILIO_PROVINCIA AND l.id_provincia = p.id
    WHERE CLI_USUARIO_NOMBRE IS NOT NULL
    GO


INSERT INTO CHIRIPIORCA.Vendedor(cuit,
                                razon_social,
                                mail,
                                usuario)
SELECT DISTINCT     VENDEDOR_CUIT,
                    VENDEDOR_RAZON_SOCIAL,
                    VENDEDOR_MAIL,
                    VEN_USUARIO_NOMBRE
                    FROM gd_esquema.Maestra
                    WHERE VENDEDOR_CUIT IS NOT NULL;
                    GO

INSERT INTO CHIRIPIORCA.Vendedor_usuario(nombre,
                                        usuario_contrasenia,
                                        fecha_creacion,
                                        calle,
                                        nro_calle,
                                        piso_depto,
                                        cod_postal,
                                        depto,
                                        id_localidad,
                                        cod_cliente,
                                        cod_vendedor)
SELECT DISTINCT     VEN_USUARIO_NOMBRE,
                    VEN_USUARIO_PASS,
                    VEN_USUARIO_FECHA_CREACION,
                    VEN_USUARIO_DOMICILIO_CALLE,
                    VEN_USUARIO_DOMICILIO_NRO_CALLE,
                    VEN_USUARIO_DOMICILIO_PISO,
                    VEN_USUARIO_DOMICILIO_DEPTO,
                    VEN_USUARIO_DOMICILIO_CP,
                    l.id,
                    C.codigo_cliente,
                    V.cuit
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Vendedor V on V.cuit = m.VENDEDOR_CUIT
LEFT JOIN CHIRIPIORCA.Cliente C on C.dni = m.CLIENTE_DNI and C.nombre = m.CLIENTE_NOMBRE and C.apellido = m.CLIENTE_APELLIDO
JOIN CHIRIPIORCA.Localidad l on l.nombre_localidad = m.VEN_USUARIO_DOMICILIO_LOCALIDAD
JOIN CHIRIPIORCA.Provincia p on p.nombre_provincia = m.VEN_USUARIO_DOMICILIO_PROVINCIA and p.id = l.id_provincia
WHERE VEN_USUARIO_NOMBRE IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Subrubro(nombre_subrubro,
                                 subrubro_descripcion)
SELECT DISTINCT
    PRODUCTO_SUB_RUBRO,
    R.rubro_descripcion
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Rubro R on R.rubro_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
WHERE PRODUCTO_SUB_RUBRO IS NOT NULL;
GO




INSERT INTO CHIRIPIORCA.Producto(codigo_de_producto, descripcion, subrubro, nombre_marca, precio, modelo_cod)
SELECT DISTINCT      PRODUCTO_CODIGO,
                     PRODUCTO_DESCRIPCION,
                     S.id,
                     Marca.nombre_marca,
                     PRODUCTO_PRECIO,
                     Mod.modelo_cod
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.RUBRO R on R.rubro_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
JOIN CHIRIPIORCA.Subrubro S on S.nombre_subrubro = m.PRODUCTO_SUB_RUBRO and R.rubro_descripcion = S.subrubro_descripcion
JOIN CHIRIPIORCA.Marca Marca on Marca.nombre_marca = m.PRODUCTO_MARCA
JOIN CHIRIPIORCA.Modelo Mod on Mod.modelo_cod = m.PRODUCTO_MOD_CODIGO
WHERE PRODUCTO_CODIGO IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Publicacion (codigo_de_publicacion, codigo_producto, descripcion, fecha_publicacion,
                                    fecha_vencimiento, stock, precio, costo_de_publicacion, porcentaje_por_venta, almacen, vendedor)
SELECT DISTINCT   PUBLICACION_CODIGO,
                  P.id,
                  PUBLICACION_DESCRIPCION,
                    PUBLICACION_FECHA,
                    PUBLICACION_FECHA_V,
                  PUBLICACION_STOCK,
                  PUBLICACION_PRECIO,
                    PUBLICACION_COSTO,
                    PUBLICACION_PORC_VENTA,
                    A.id_almacen,
                    V.cuit
    FROM gd_esquema.Maestra m
             JOIN CHIRIPIORCA.VENDEDOR V on m.VENDEDOR_CUIT = V.cuit AND m.VENDEDOR_RAZON_SOCIAL = V.razon_social
             JOIN CHIRIPIORCA.RUBRO R on R.rubro_descripcion = m.PRODUCTO_RUBRO_DESCRIPCION
             JOIN CHIRIPIORCA.Subrubro S on S.nombre_subrubro = m.PRODUCTO_SUB_RUBRO and R.rubro_descripcion = S.subrubro_descripcion
             JOIN CHIRIPIORCA.ALMACEN A on ALMACEN_CODIGO =  A.id_almacen
             JOIN CHIRIPIORCA.PRODUCTO P on m.PRODUCTO_CODIGO = P.codigo_de_producto AND P.subrubro = S.id
GO

INSERT INTO CHIRIPIORCA.Medio_de_pago(id_pago, tipo_medio)
SELECT DISTINCT PAGO_MEDIO_PAGO,
                T.tipo_medio_de_pago
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Tipo_medio_de_pago T on T.tipo_medio_de_pago = m.PAGO_TIPO_MEDIO_PAGO
GO

INSERT INTO CHIRIPIORCA.Detalle_de_factura (
    publicacion,
    precio,
    cantidad,
    subtotal,
    detalle_factura
)
SELECT DISTINCT
    P.id,
    m.FACTURA_DET_PRECIO,
    m.FACTURA_DET_CANTIDAD,
    m.FACTURA_DET_SUBTOTAL,
    T.detalle_factura
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Publicacion P 
    ON P.codigo_de_publicacion = m.PUBLICACION_CODIGO  and P.costo_de_publicacion = m.PUBLICACION_COSTO
	JOIN CHIRIPIORCA.Tipo_detalle_factura T
    ON T.detalle_factura = m.FACTURA_DET_TIPO
WHERE m.FACTURA_DET_CANTIDAD IS NOT NULL;
GO

WITH FacturaDetalles AS (
    SELECT DISTINCT
        m.FACTURA_NUMERO,
        Det.id AS detalle_factura_id,
        m.FACTURA_FECHA,
        m.FACTURA_TOTAL
    FROM gd_esquema.Maestra m
    JOIN CHIRIPIORCA.Publicacion p on p.codigo_de_publicacion =m.PUBLICACION_CODIGO and p.costo_de_publicacion = m.PUBLICACION_COSTO
	JOIN CHIRIPIORCA.Detalle_de_factura Det on Det.publicacion = p.id
        AND Det.cantidad = m.FACTURA_DET_CANTIDAD
    WHERE m.PUBLICACION_CODIGO IS NOT NULL
)
INSERT INTO CHIRIPIORCA.Facturacion (
    numero_de_factura,
    detalle_factura,
    fecha_de_la_factura,
    importe_total
)
SELECT DISTINCT
    FACTURA_NUMERO,
    MIN(detalle_factura_id), -- Aseguramos un único detalle por factura
    FACTURA_FECHA,
    FACTURA_TOTAL
FROM FacturaDetalles
GROUP BY FACTURA_NUMERO, FACTURA_FECHA, FACTURA_TOTAL;
GO

/*INSERT INTO CHIRIPIORCA.Facturacion (
    numero_de_factura,
    detalle_factura,
    fecha_de_la_factura,
    importe_total
)
SELECT DISTINCT
    m.FACTURA_NUMERO,
    Det.id,
    m.FACTURA_FECHA,
    m.FACTURA_TOTAL
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Detalle_de_factura Det
    ON Det.publicacion = m.PUBLICACION_CODIGO and Det.cantidad = m.FACTURA_DET_CANTIDAD
WHERE m.PUBLICACION_CODIGO IS NOT NULL AND m.FACTURA_FECHA IS NOT NULL;*/


INSERT INTO CHIRIPIORCA.Detalle_de_venta(codigo_de_publicacion,cantidad,precio, subtotal)
SELECT
	  P.id,
      CONVERT(numeric, m.VENTA_DET_CANT),
      CONVERT(numeric, m.VENTA_DET_PRECIO),
      CONVERT(numeric, m.VENTA_DET_SUB_TOTAL)
       
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Publicacion P on P.codigo_de_publicacion = m.PUBLICACION_CODIGO and P.costo_de_publicacion = m.PUBLICACION_COSTO 
WHERE m.VENTA_CODIGO IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Venta(cod_venta, cliente_usuario, fecha_hora, detalle_venta, Total)
SELECT 
    DISTINCT m.VENTA_CODIGO,
    C.codigo_cliente,
    m.VENTA_FECHA,
    NULL, -- Detalle de venta puede ir vacío temporalmente
    m.VENTA_TOTAL
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Cliente C 
  ON C.dni = m.CLIENTE_DNI AND C.nombre = m.CLIENTE_Nombre AND C.apellido = m.CLIENTE_APELLIDO AND C.mail = m.CLIENTE_MAIL
WHERE m.VENTA_CODIGO IS NOT NULL;

INSERT INTO CHIRIPIORCA.Envio(tipo_de_envio,horario_de_inicio, horario_de_fin,fecha_hora_de_entrega, costo_envio,fecha_programada, id_venta )
SELECT DISTINCT
    T.envio,
    ENVIO_HORA_INICIO,
    ENVIO_HORA_FIN_INICIO,
    ENVIO_FECHA_ENTREGA,
    ENVIO_COSTO,
    ENVIO_FECHA_PROGAMADA,
    V.id
FROM gd_esquema.Maestra m
LEFT JOIN CHIRIPIORCA.Tipo_envio T on T.envio = m.ENVIO_TIPO
JOIN CHIRIPIORCA.Venta V on V.cod_venta = m.VENTA_CODIGO
WHERE m.ENVIO_HORA_INICIO IS NOT NULL and T.envio IS NOT NULL and V.id IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Pago (
    id_venta,
    fecha,
    id_medio_pago,
    importe,
    nro_tarjeta,
    fecha_de_vencimiento_tarjeta,
    cantidad_cuotas
)
SELECT
      V.id,
      m.PAGO_FECHA,
      MIN(T.id_pago),  -- Usamos MIN para seleccionar solo un id_pago por grupo
      m.PAGO_IMPORTE,
      m.PAGO_NRO_TARJETA,
      m.PAGO_FECHA_VENC_TARJETA,
      m.PAGO_CANT_CUOTAS
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Venta V ON V.cod_venta = m.VENTA_CODIGO
JOIN CHIRIPIORCA.Medio_de_pago T ON T.tipo_medio = m.PAGO_TIPO_MEDIO_PAGO
WHERE m.PAGO_IMPORTE IS NOT NULL
GROUP BY
      V.id,
      m.PAGO_FECHA,
      m.PAGO_IMPORTE,
      m.PAGO_NRO_TARJETA,
      m.PAGO_FECHA_VENC_TARJETA,
      m.PAGO_CANT_CUOTAS;
GO

UPDATE CHIRIPIORCA.Venta
SET detalle_venta = D.id
FROM CHIRIPIORCA.Venta V
JOIN gd_esquema.Maestra m ON V.cod_venta = m.VENTA_CODIGO
JOIN CHIRIPIORCA.Detalle_de_venta D
  ON D.codigo_de_publicacion = (SELECT id FROM CHIRIPIORCA.Publicacion WHERE codigo_de_publicacion = m.PUBLICACION_CODIGO AND costo_de_publicacion = m.PUBLICACION_COSTO)
 AND D.cantidad = CONVERT(numeric, m.VENTA_DET_CANT)
 AND D.precio = CONVERT(numeric, m.VENTA_DET_PRECIO)
 AND D.subtotal = CONVERT(numeric, m.VENTA_DET_SUB_TOTAL);