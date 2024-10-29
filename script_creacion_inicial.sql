USE [GD2C2024]
GO
-- Eliminación de tablas dependientes en orden
IF OBJECT_ID(N'CHIRIPIORCA.Envio', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Envio;
IF OBJECT_ID(N'CHIRIPIORCA.Pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Pago;
IF OBJECT_ID(N'CHIRIPIORCA.Venta', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Venta;
IF OBJECT_ID(N'CHIRIPIORCA.Detalle_de_venta', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Detalle_de_venta;
IF OBJECT_ID(N'CHIRIPIORCA.Facturacion', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Facturacion;
IF OBJECT_ID(N'CHIRIPIORCA.Detalle_de_factura', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Detalle_de_factura;
IF OBJECT_ID(N'CHIRIPIORCA.Tipo_detalle_factura', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Tipo_detalle_factura;
IF OBJECT_ID(N'CHIRIPIORCA.Cliente', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Cliente;
IF OBJECT_ID(N'CHIRIPIORCA.Cliente_usuario', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Cliente_usuario;
IF OBJECT_ID(N'CHIRIPIORCA.Publicacion', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Publicacion;
IF OBJECT_ID(N'CHIRIPIORCA.Vendedor', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Vendedor;
IF OBJECT_ID(N'CHIRIPIORCA.Vendedor_usuario', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Vendedor_usuario;
IF OBJECT_ID(N'CHIRIPIORCA.Producto', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Producto;
IF OBJECT_ID(N'CHIRIPIORCA.Subrubro', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Subrubro;
IF OBJECT_ID(N'CHIRIPIORCA.Marca', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Marca;
IF OBJECT_ID(N'CHIRIPIORCA.Medio_de_pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Medio_de_pago;
IF OBJECT_ID(N'CHIRIPIORCA.Tipo_medio_de_pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Tipo_medio_de_pago;
IF OBJECT_ID(N'CHIRIPIORCA.Rubro', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Rubro;
IF OBJECT_ID(N'CHIRIPIORCA.Modelo', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Modelo;
IF OBJECT_ID(N'CHIRIPIORCA.Tipo_envio', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Tipo_envio;
IF OBJECT_ID(N'CHIRIPIORCA.Almacen', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Almacen;
--borrado de schema
IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'CHIRIPIORCA') DROP SCHEMA CHIRIPIORCA;
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------(2)CREACION DE ESQUEMA Y TABLAS------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Creacion de esquema
CREATE SCHEMA CHIRIPIORCA;
GO



CREATE TABLE CHIRIPIORCA.Tipo_medio_de_pago (
                                                tipo_medio_de_pago NVARCHAR(50) PRIMARY KEY,

);

-- 1. Tablas independientes primero
CREATE TABLE CHIRIPIORCA.Modelo(
                                   modelo_cod DECIMAL(18, 0) PRIMARY KEY not null,
                                   modelo_descripcion NVARCHAR(50) not null
);
GO

CREATE TABLE CHIRIPIORCA.Rubro(
                                  rubro_descripcion NVARCHAR(50) PRIMARY KEY not null
);
GO

CREATE TABLE CHIRIPIORCA.Medio_de_pago(
                                          id_pago NVARCHAR(50) PRIMARY KEY NOT NULL,
                                          tipo_medio NVARCHAR(50) NOT NULL,
                                          FOREIGN KEY (tipo_medio) REFERENCES CHIRIPIORCA.Tipo_medio_de_pago(tipo_medio_de_pago)
);
CREATE TABLE CHIRIPIORCA.Marca (
                                   nombre_marca NVARCHAR(50) PRIMARY KEY not null,

);


CREATE TABLE CHIRIPIORCA.Subrubro (
                                      id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
                                      nombre_subrubro NVARCHAR(50) not null,
                                      subrubro_descripcion NVARCHAR(50) not null,
                                      FOREIGN KEY (subrubro_descripcion) REFERENCES CHIRIPIORCA.Rubro(rubro_descripcion)
);

-- 3. Tablas que dependen de Marca y Subrubro
CREATE TABLE CHIRIPIORCA.Producto (
                                      id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY not null,
                                      codigo_de_producto NVARCHAR(50) not null,
                                      descripcion NVARCHAR(50) not null,
                                      subrubro DECIMAL(18,0),
                                      nombre_marca NVARCHAR(50),
                                      precio DECIMAL(18, 0) not null,
                                      modelo_cod DECIMAL(18, 0),
                                      FOREIGN KEY (modelo_cod) REFERENCES CHIRIPIORCA.Modelo(modelo_cod),
                                      FOREIGN KEY (subrubro) REFERENCES CHIRIPIORCA.Subrubro(id),
                                      FOREIGN KEY (nombre_marca) REFERENCES CHIRIPIORCA.Marca(nombre_marca)
);

CREATE TABLE CHIRIPIORCA.Almacen(
                                    id_almacen DECIMAL(18, 0) PRIMARY KEY not null,
                                    calle VARCHAR(50) not null,
                                    numero_calle DECIMAL(18, 0) not null,
                                    costo_al_dia DECIMAL(18, 0) not null,
                                    localidad VARCHAR(50) not null,
                                    provincia VARCHAR(50) not null
);

CREATE TABLE CHIRIPIORCA.Vendedor_usuario(
                                             nombre NVARCHAR(50) PRIMARY KEY,
                                             usuario_contrasenia NVARCHAR(50) not null,
                                             fecha_creacion DATE not null,
                                             nro_calle DECIMAL(18, 0) not null,
                                             calle NVARCHAR(50) not null,
                                             piso_depto NVARCHAR(50) not null,
                                             cod_postal NVARCHAR(50) not null,
                                             depto NVARCHAR(50) not null,
                                             localidad NVARCHAR(50) not null,
                                             provincia NVARCHAR(50) not null
);

CREATE TABLE CHIRIPIORCA.Vendedor (
                                      cuit NVARCHAR(50) PRIMARY KEY not null,
                                      razon_social NVARCHAR(50) not null,
                                      mail NVARCHAR(50) not null,
                                      usuario NVARCHAR(50),
                                      FOREIGN KEY (usuario) REFERENCES CHIRIPIORCA.Vendedor_usuario(nombre)
);

-- 4. Tablas con referencias más complejas
CREATE TABLE CHIRIPIORCA.Publicacion(
                                         codigo_de_publicacion DECIMAL(18, 0) PRIMARY KEY not null,
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

CREATE TABLE CHIRIPIORCA.Tipo_detalle_factura (

                                                  detalle_factura NVARCHAR(50) PRIMARY KEY,

);
CREATE TABLE CHIRIPIORCA.Detalle_de_factura (
                                                id DECIMAL(18, 0) PRIMARY KEY NOT NULL,
                                                publicacion DECIMAL(18, 0),
                                                concepto VARCHAR(50) NOT NULL,
                                                cantidad DECIMAL(18, 0) NOT NULL,
                                                subtotal DECIMAL(18, 0) NOT NULL,
                                                precio DECIMAL(18, 0) NOT NULL,
                                                detalle_factura NVARCHAR(50) NOT NULL,
                                                FOREIGN KEY (publicacion) REFERENCES CHIRIPIORCA.Publicacion(codigo_de_publicacion),
                                                FOREIGN KEY (detalle_factura) REFERENCES CHIRIPIORCA.Tipo_detalle_factura(detalle_factura)
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
                                            localidad NVARCHAR(50) not null,
                                            provincia NVARCHAR(50) not null
);



CREATE TABLE CHIRIPIORCA.Facturacion (
                                         numero_de_factura DECIMAL(18, 0) PRIMARY KEY,
                                         detalle_factura DECIMAL(18, 0),
                                         fecha_de_la_factura DATE NOT NULL,
                                         importe_total DECIMAL(18, 0) NOT NULL,
                                         usuario_vendedor NVARCHAR(50),
                                         usuario_cliente DECIMAL(18,0),
                                         FOREIGN KEY (detalle_factura) REFERENCES CHIRIPIORCA.Detalle_de_factura(id),
                                         FOREIGN KEY (usuario_vendedor) REFERENCES CHIRIPIORCA.Vendedor_usuario(nombre),
                                         FOREIGN KEY (usuario_cliente) REFERENCES CHIRIPIORCA.Cliente_usuario(codigo_usuario)
);

CREATE TABLE CHIRIPIORCA.Detalle_de_venta (
                                              id DECIMAL(18, 0) PRIMARY KEY not null,
                                              precio DECIMAL(18, 0) not null,
                                              cantidad DECIMAL(18, 0) not null,
                                              subtotal DECIMAL(18, 0) not null,
                                              codigo_de_publicacion DECIMAL(18, 0),
                                              FOREIGN KEY (codigo_de_publicacion) REFERENCES CHIRIPIORCA.Publicacion(codigo_de_publicacion)
);

CREATE TABLE CHIRIPIORCA.Venta (
                                   cod_venta DECIMAL(18, 0) PRIMARY KEY not null,
                                   cliente_usuario DECIMAL(18,0) NULL,
                                   FechaHora DATE not null,
                                   DetalleVenta DECIMAL(18, 0),
                                   Total DECIMAL(18, 0) not null,
                                   FOREIGN KEY (cliente_usuario) REFERENCES CHIRIPIORCA.Cliente_usuario(codigo_usuario),
                                   FOREIGN KEY (DetalleVenta) REFERENCES CHIRIPIORCA.Detalle_de_venta(id)
);
CREATE TABLE CHIRIPIORCA.Tipo_envio(
                                       envio VARCHAR(30) PRIMARY KEY
);

CREATE TABLE CHIRIPIORCA.Envio (
                                   numero_de_envio DECIMAL(18, 0) PRIMARY KEY not null,
                                   cod_venta DECIMAL(18, 0),
                                   fecha_programada DATE not null,
                                   horario_de_inicio DATE not null,
                                   horario_de_fin DATE not null,
                                   costo_envio DECIMAL(18, 0) not null,
                                   fecha_hora_de_entrega DATE not null,
                                   tipo_de_envio VARCHAR(30) not null,
                                   FOREIGN KEY (tipo_de_envio) REFERENCES CHIRIPIORCA.Tipo_envio(envio),
                                   FOREIGN KEY (cod_venta) REFERENCES CHIRIPIORCA.Venta(cod_venta)
);

CREATE TABLE CHIRIPIORCA.Pago (
                                  numero_de_pago DECIMAL(18, 0) PRIMARY KEY not null,
                                  cod_venta DECIMAL(18, 0),
                                  fecha DATE not null,
                                  tipo_medio_de_pago NVARCHAR(50),
                                  importe DECIMAL(18, 0) not null,
                                  nro_tarjeta NVARCHAR(50) not null,
                                  fecha_de_vencimiento_tarjeta DATE not null,
                                  cantidad_cuotas DECIMAL(18, 0) not null,
                                  FOREIGN KEY (cod_venta) REFERENCES CHIRIPIORCA.Venta(cod_venta),
                                  FOREIGN KEY (tipo_medio_de_pago) REFERENCES CHIRIPIORCA.Medio_de_pago(id_pago)
);

CREATE TABLE CHIRIPIORCA.Cliente (
                                     codigo_cliente DECIMAL(18, 0) IDENTITY(1, 1) PRIMARY KEY,
                                     dni  DECIMAL(18, 0) NOT NULL,
                                     mail NVARCHAR(50) NOT NULL,
                                     nombre NVARCHAR(50) NOT NULL,
                                     apellido NVARCHAR(50) NOT NULL,
                                     ven_usuario NVARCHAR(50) NULL,
                                     fecha_nacimiento DATE NOT NULL,
                                     cli_usuario DECIMAL(18,0) NULL,
                                     FOREIGN KEY (ven_usuario) REFERENCES CHIRIPIORCA.Vendedor_usuario(nombre),
                                     FOREIGN KEY (cli_usuario) REFERENCES CHIRIPIORCA.Cliente_usuario(codigo_usuario)

);
-- TiposDetalleFactura
INSERT INTO CHIRIPIORCA.Tipo_detalle_factura (detalle_factura)
SELECT DISTINCT FACTURA_DET_TIPO FROM gd_esquema.Maestra
WHERE FACTURA_DET_TIPO IS NOT NULL;
GO
--
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
-- TipoMedioDePago
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
                                localidad,
                                provincia)
SELECT DISTINCT     ALMACEN_CODIGO,
                    ALMACEN_CALLE,
                    ALMACEN_NRO_CALLE,
                    ALMACEN_COSTO_DIA_AL,
                    ALMACEN_Localidad,
                    ALMACEN_PROVINCIA FROM gd_esquema.Maestra
WHERE ALMACEN_CODIGO IS NOT NULL;
GO
INSERT INTO CHIRIPIORCA.Vendedor_usuario(nombre,
                                        usuario_contrasenia,
                                        fecha_creacion,
                                        calle,
                                        nro_calle,
                                        piso_depto,
                                        cod_postal,
                                        depto,
                                        localidad,
                                        provincia)
SELECT DISTINCT     VEN_USUARIO_NOMBRE,
                    VEN_USUARIO_PASS,
                    VEN_USUARIO_FECHA_CREACION,
                    VEN_USUARIO_DOMICILIO_CALLE,
                    VEN_USUARIO_DOMICILIO_NRO_CALLE,
                    VEN_USUARIO_DOMICILIO_PISO,
                    VEN_USUARIO_DOMICILIO_DEPTO,
                    VEN_USUARIO_DOMICILIO_CP,
                    VEN_USUARIO_DOMICILIO_LOCALIDAD,
                    VEN_USUARIO_DOMICILIO_PROVINCIA FROM gd_esquema.Maestra
WHERE VEN_USUARIO_NOMBRE IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Cliente_usuario(nombre,
                                         usuario_contrasenia,
                                         fecha_creacion,
                                         calle,
                                         nro_calle,
                                         piso_depto,
                                         cod_postal,
                                         depto,
                                         localidad,
                                         provincia)

SELECT DISTINCT     CLI_USUARIO_NOMBRE,
                    CLI_USUARIO_PASS,
                    CLI_USUARIO_FECHA_CREACION,
                    CLI_USUARIO_DOMICILIO_CALLE,
                    CLI_USUARIO_DOMICILIO_NRO_CALLE,
                    CLI_USUARIO_DOMICILIO_PISO,
                    CLI_USUARIO_DOMICILIO_DEPTO,
                    CLI_USUARIO_DOMICILIO_CP,
                    CLI_USUARIO_DOMICILIO_LOCALIDAD,
                    CLI_USUARIO_DOMICILIO_PROVINCIA FROM gd_esquema.Maestra
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

JOIN CHIRIPIORCA.Vendedor_usuario u on
                        u.nombre = VEN_USUARIO_NOMBRE
WHERE VENDEDOR_CUIT IS NOT NULL;
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
