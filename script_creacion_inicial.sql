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
--borrado de schema
IF EXISTS (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = 'CHIRIPIORCA') DROP SCHEMA CHIRIPIORCA;
GO
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------(2)CREACION DE ESQUEMA Y TABLAS------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Creacion de esquema
CREATE SCHEMA CHIRIPIORCA;
GO
--16 ya esta
CREATE TABLE CHIRIPIORCA.Cliente (
                                     codigo_cliente DECIMAL(18, 0) IDENTITY(1, 1) PRIMARY KEY,
                                     dni  DECIMAL(18, 0) NOT NULL,
                                     mail NVARCHAR(50) NOT NULL,
                                     nombre NVARCHAR(50) NOT NULL,
                                     apellido NVARCHAR(50) NOT NULL,
                                     fecha_nacimiento DATE NOT NULL,
);

--4. ya esta
CREATE TABLE CHIRIPIORCA.Tipo_medio_de_pago (
                                                tipo_medio_de_pago NVARCHAR(50) PRIMARY KEY,

);

-- 1. YA ESTA
CREATE TABLE CHIRIPIORCA.Modelo(
                                   modelo_cod DECIMAL(18, 0) PRIMARY KEY not null,
                                   modelo_descripcion NVARCHAR(50) not null
);
GO
-- 2. Ya esta
CREATE TABLE CHIRIPIORCA.Rubro(
                                  rubro_descripcion NVARCHAR(50) PRIMARY KEY not null
);
GO
-- 3. Ya esta
CREATE TABLE CHIRIPIORCA.Medio_de_pago(
                                          id_pago NVARCHAR(50) PRIMARY KEY NOT NULL,
                                          tipo_medio NVARCHAR(50) NOT NULL,
                                          FOREIGN KEY (tipo_medio) REFERENCES CHIRIPIORCA.Tipo_medio_de_pago(tipo_medio_de_pago)
);
-- 5. ya esta
CREATE TABLE CHIRIPIORCA.Marca (
                                   nombre_marca NVARCHAR(50) PRIMARY KEY not null,

);

-- 6 ya esta
CREATE TABLE CHIRIPIORCA.Subrubro (
                                      id DECIMAL(18,0) IDENTITY(1,1) PRIMARY KEY,
                                      nombre_subrubro NVARCHAR(50) not null,
                                      subrubro_descripcion NVARCHAR(50) not null,
                                      FOREIGN KEY (subrubro_descripcion) REFERENCES CHIRIPIORCA.Rubro(rubro_descripcion)
);

-- 7 ya esta
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
-- 8 ya esta
CREATE TABLE CHIRIPIORCA.Almacen(
                                    id_almacen DECIMAL(18, 0) PRIMARY KEY not null,
                                    calle VARCHAR(50) not null,
                                    numero_calle DECIMAL(18, 0) not null,
                                    costo_al_dia DECIMAL(18, 0) not null,
                                    localidad VARCHAR(50) not null,
                                    provincia VARCHAR(50) not null
);
-- 10 ya esta
CREATE TABLE CHIRIPIORCA.Vendedor (
                                      cuit NVARCHAR(50) PRIMARY KEY not null,
                                      razon_social NVARCHAR(50) not null,
                                      mail NVARCHAR(50) not null,
                                      usuario NVARCHAR(50),
);
-- 9 ya esta
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
                                             provincia NVARCHAR(50) not null,
                                             cod_cliente DECIMAL(18,0),
                                             cod_vendedor NVARCHAR(50),
                                             FOREIGN KEY (cod_cliente) REFERENCES CHIRIPIORCA.Cliente(codigo_cliente),
                                             FOREIGN KEY (cod_vendedor) REFERENCES CHIRIPIORCA.Vendedor(cuit)

);


-- 11 ya esta
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
--12 ya esta
CREATE TABLE CHIRIPIORCA.Tipo_detalle_factura (

                                                  detalle_factura NVARCHAR(50) PRIMARY KEY,

);
--15 ya esta
CREATE TABLE CHIRIPIORCA.Detalle_de_factura (
                                                id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY,
                                                publicacion DECIMAL(18, 0) NOT NULL,
                                                concepto VARCHAR(50) NULL,
                                                cantidad DECIMAL(18, 0)NOT NULL,
                                                subtotal DECIMAL(18, 0)  NULL,
                                                precio DECIMAL(18, 0)  NULL,
                                                detalle_factura NVARCHAR(50) NOT NULL,
                                                id_cliente DECIMAL(18, 0) NOT NULL,
                                                FOREIGN KEY (publicacion) REFERENCES CHIRIPIORCA.Publicacion(codigo_de_publicacion),
                                                FOREIGN KEY (detalle_factura) REFERENCES CHIRIPIORCA.Tipo_detalle_factura(detalle_factura),
                                                FOREIGN KEY (id_cliente) REFERENCES CHIRIPIORCA.Cliente(codigo_cliente)
);
GO
-- 13 ya esta
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
                                            provincia NVARCHAR(50) not null,
                                            cod_cliente DECIMAL(18,0),
                                            FOREIGN KEY (cod_cliente) REFERENCES CHIRIPIORCA.Cliente(codigo_cliente)
);


--17 qsy
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
--hecha 19
CREATE TABLE CHIRIPIORCA.Detalle_de_venta (
                                              id DECIMAL(18, 0) IDENTITY(1,1) PRIMARY KEY not null,
                                              precio DECIMAL(18, 0) not null,
                                              cantidad DECIMAL(18, 0) not null,
                                              subtotal DECIMAL(18, 0) not null,
                                              codigo_de_publicacion DECIMAL(18, 0),
                                              FOREIGN KEY (codigo_de_publicacion) REFERENCES CHIRIPIORCA.Publicacion(codigo_de_publicacion),

);
-- 20
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
-- 14 ya esta
CREATE TABLE CHIRIPIORCA.Tipo_envio(
                                       envio VARCHAR(30) PRIMARY KEY
);
--18 esta
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

-- TiposDetalleFactura
INSERT INTO CHIRIPIORCA.Tipo_detalle_factura (detalle_factura)
SELECT DISTINCT m.FACTURA_DET_TIPO
FROM gd_esquema.Maestra m
WHERE m.FACTURA_DET_TIPO IS NOT NULL;
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
                                         localidad,
                                         provincia,
                                         cod_cliente)

SELECT DISTINCT     CLI_USUARIO_NOMBRE,
                    CLI_USUARIO_PASS,
                    CLI_USUARIO_FECHA_CREACION,
                    CLI_USUARIO_DOMICILIO_CALLE,
                    CLI_USUARIO_DOMICILIO_NRO_CALLE,
                    CLI_USUARIO_DOMICILIO_PISO,
                    CLI_USUARIO_DOMICILIO_DEPTO,
                    CLI_USUARIO_DOMICILIO_CP,
                    CLI_USUARIO_DOMICILIO_LOCALIDAD,
                    CLI_USUARIO_DOMICILIO_PROVINCIA,
                    C.codigo_cliente
                    FROM gd_esquema.Maestra m
    JOIN CHIRIPIORCA.Cliente C on C.dni = m.CLIENTE_DNI and C.nombre = m.CLIENTE_NOMBRE and C.apellido = m.CLIENTE_APELLIDO
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
                                        localidad,
                                        provincia,
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
                    VEN_USUARIO_DOMICILIO_LOCALIDAD,
                    VEN_USUARIO_DOMICILIO_PROVINCIA,
                    C.codigo_cliente,
                    V.cuit
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Vendedor V on V.cuit = m.VENDEDOR_CUIT
LEFT JOIN CHIRIPIORCA.Cliente C on C.dni = m.CLIENTE_DNI and C.nombre = m.CLIENTE_NOMBRE and C.apellido = m.CLIENTE_APELLIDO
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

-- Inserción en Detalle_de_factura
INSERT INTO CHIRIPIORCA.Detalle_de_factura (
    publicacion,
    precio,
    cantidad,
    subtotal,
    detalle_factura,
    id_cliente
)
SELECT DISTINCT
    P.codigo_de_publicacion,
    m.FACTURA_DET_PRECIO,
    m.FACTURA_DET_CANTIDAD,
    m.FACTURA_DET_SUBTOTAL,
    T.detalle_factura,
    C.codigo_cliente
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Publicacion P 
    ON P.codigo_de_publicacion = m.PUBLICACION_CODIGO
JOIN CHIRIPIORCA.Tipo_detalle_factura T 
    ON T.detalle_factura = m.FACTURA_DET_TIPO
JOIN CHIRIPIORCA.Cliente C on C.dni = m.CLIENTE_DNI and C.nombre = m.CLIENTE_Nombre and C.apellido = m.CLIENTE_APELLIDO
WHERE m.FACTURA_DET_CANTIDAD IS NOT NULL;

-- Inserción en Facturacion
INSERT INTO CHIRIPIORCA.Facturacion (
    numero_de_factura,
    detalle_factura,
    fecha_de_la_factura,
    importe_total,
    vendedor
)
SELECT DISTINCT
    m.FACTURA_NUMERO,
    Det.id,
    m.FACTURA_FECHA,
    m.FACTURA_TOTAL,
    V.cuit
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Detalle_de_factura Det 
    ON Det.detalle_factura = m.FACTURA_DET_TIPO 
    AND Det.precio = m.FACTURA_DET_PRECIO
JOIN CHIRIPIORCA.Vendedor V on V.cuit = m.VENDEDOR_CUIT
WHERE m.FACTURA_NUMERO IS NOT NULL;


INSERT INTO CHIRIPIORCA.Detalle_de_venta( precio,cantidad,subtotal,codigo_de_publicacion)
SELECT DISTINCT
      VENTA_DET_CANT,
      VENTA_DET_PRECIO,
      VENTA_DET_SUB_TOTAL,
      P.codigo_de_publicacion
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Publicacion P on P.codigo_de_publicacion = m.PUBLICACION_CODIGO
WHERE m.VENTA_DET_CANT IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Venta(cod_venta, cliente_usuario, fecha_hora, detalle_venta, Total)
SELECT DISTINCT       VENTA_CODIGO,
                      C.codigo_cliente,
                      VENTA_FECHA,
                      D.id,
                      VENTA_TOTAL
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Cliente C on C.dni = m.CLIENTE_DNI and C.nombre = m.CLIENTE_Nombre and C.apellido = m.CLIENTE_APELLIDO
JOIN CHIRIPIORCA.Detalle_de_venta D on D.codigo_de_publicacion = m.PUBLICACION_CODIGO
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
JOIN CHIRIPIORCA.Tipo_envio T on T.envio = m.ENVIO_TIPO
JOIN CHIRIPIORCA.Venta V on V.cod_venta = m.VENTA_CODIGO and V.Total = VENTA_TOTAL
WHERE T.envio IS NOT NULL;
GO

INSERT INTO CHIRIPIORCA.Pago(id_venta, fecha, id_medio_pago,
                             importe, nro_tarjeta,
                             fecha_de_vencimiento_tarjeta, cantidad_cuotas)

SELECT DISTINCT
      V.id,
      PAGO_FECHA,
      T.id_pago,
      PAGO_IMPORTE,
      PAGO_NRO_TARJETA,
      PAGO_FECHA_VENC_TARJETA,
      PAGO_CANT_CUOTAS
FROM gd_esquema.Maestra m
JOIN CHIRIPIORCA.Medio_de_pago T on T.tipo_medio = m.PAGO_TIPO_MEDIO_PAGO
JOIN CHIRIPIORCA.Venta V on V.cod_venta = m.VENTA_CODIGO and V.Total = VENTA_TOTAL
WHERE m.PAGO_IMPORTE IS NOT NULL;
GO
