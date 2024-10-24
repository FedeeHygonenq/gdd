USE [GD2C2024]
GO


-- Desactivar todas las restricciones de clave foránea
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT ALL";

-- Eliminar tablas en orden inverso a su creación
IF OBJECT_ID(N'CHIRIPIORCA.Detalle_de_venta', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Detalle_de_venta;
IF OBJECT_ID(N'CHIRIPIORCA.Venta', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Venta;
IF OBJECT_ID(N'CHIRIPIORCA.Envio', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Envio;
IF OBJECT_ID(N'CHIRIPIORCA.Tipo_envio', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Tipo_envio;
IF OBJECT_ID(N'CHIRIPIORCA.Pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Pago;
IF OBJECT_ID(N'CHIRIPIORCA.Facturacion', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Facturacion;
IF OBJECT_ID(N'CHIRIPIORCA.Detalle_de_factura', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Detalle_de_factura;
IF OBJECT_ID(N'CHIRIPIORCA.Cliente', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Cliente;
IF OBJECT_ID(N'CHIRIPIORCA.Cliente_usuario', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Cliente_usuario;
IF OBJECT_ID(N'CHIRIPIORCA.Publicacion', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Publicacion;
IF OBJECT_ID(N'CHIRIPIORCA.Vendedor', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Vendedor;
IF OBJECT_ID(N'CHIRIPIORCA.Vendedor_usuario', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Vendedor_usuario;
IF OBJECT_ID(N'CHIRIPIORCA.Almacen', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Almacen;
IF OBJECT_ID(N'CHIRIPIORCA.Producto', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Producto;
IF OBJECT_ID(N'CHIRIPIORCA.Subrubro', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Subrubro;
IF OBJECT_ID(N'CHIRIPIORCA.Marca', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Marca;
IF OBJECT_ID(N'CHIRIPIORCA.Medio_de_pago', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Medio_de_pago;
IF OBJECT_ID(N'CHIRIPIORCA.Rubro', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Rubro;
IF OBJECT_ID(N'CHIRIPIORCA.Modelo', N'U') IS NOT NULL DROP TABLE CHIRIPIORCA.Modelo;
-- (Opcional) Reactivar las restricciones de clave foránea
EXEC sp_msforeachtable "ALTER TABLE ? CHECK CONSTRAINT ALL";

-- 1. Tablas independientes primero
CREATE TABLE CHIRIPIORCA.Modelo(
                                    modelo_cod DECIMAL(18, 0) PRIMARY KEY not null,
                                    modelo_descripcion NVARCHAR(50) not null
);

CREATE TABLE CHIRIPIORCA.Rubro(
                                   rubro_descripcion NVARCHAR(50) PRIMARY KEY not null
);

CREATE TABLE CHIRIPIORCA.Medio_de_pago(
                                           id_pago NVARCHAR(50) PRIMARY KEY not null
);

CREATE TABLE CHIRIPIORCA.Marca (
                                   nombre_marca NVARCHAR(50) PRIMARY KEY not null,
                                   modelo_cod DECIMAL(18, 0),
                                   FOREIGN KEY (modelo_cod) REFERENCES CHIRIPIORCA.Modelo(modelo_cod)
);

CREATE TABLE CHIRIPIORCA.Subrubro (
                                      nombre_subrubro NVARCHAR(50) PRIMARY KEY not null,
                                      subrubro_descripcion NVARCHAR(50) not null,
                                      FOREIGN KEY (subrubro_descripcion) REFERENCES CHIRIPIORCA.Rubro(rubro_descripcion)
);

-- 3. Tablas que dependen de Marca y Subrubro
CREATE TABLE CHIRIPIORCA.Producto (
                                      codigo_de_producto DECIMAL(18, 0) PRIMARY KEY not null,
                                      descripcion NVARCHAR(50) not null,
                                      subrubro NVARCHAR(50),
                                      nombre_marca NVARCHAR(50),
                                      precio DECIMAL(18, 0) not null,
                                      FOREIGN KEY (subrubro) REFERENCES CHIRIPIORCA.Subrubro(nombre_subrubro),
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
                                              id_vendedor_usuario DECIMAL(18, 0) PRIMARY KEY not null,
                                              nombre NVARCHAR(50) not null,
                                              usuario_contrasenia NVARCHAR(50) not null,
                                              fecha_creacion_usuario DATE not null,
                                              nro_calle_cliente NVARCHAR(50) not null,
                                              piso_depto_cliente NVARCHAR(50) not null,
                                              localidad_cliente NVARCHAR(50) not null,
                                              provincia_cliente NVARCHAR(50) not null
);

CREATE TABLE CHIRIPIORCA.Vendedor (
                                      cuit NVARCHAR(50) PRIMARY KEY not null,
                                      razon_social NVARCHAR(50) not null,
                                      mail NVARCHAR(50) not null,
                                      codigo_producto DECIMAL(18, 0),
                                      FOREIGN KEY (codigo_producto) REFERENCES CHIRIPIORCA.Vendedor_usuario(id_vendedor_usuario)
);

-- 4. Tablas con referencias más complejas
CREATE TABLE CHIRIPIORCA.Publicacion (
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
                                         R_vendedor NVARCHAR(50),
                                         FOREIGN KEY (codigo_producto) REFERENCES CHIRIPIORCA.Producto(codigo_de_producto),
                                         FOREIGN KEY (almacen) REFERENCES CHIRIPIORCA.Almacen(id_almacen),
                                         FOREIGN KEY (R_vendedor) REFERENCES CHIRIPIORCA.Vendedor(cuit)
);
CREATE TABLE CHIRIPIORCA.Cliente_usuario(
                                             id_dni_usuario DECIMAL(18, 0) PRIMARY KEY not null,
                                             nombre NVARCHAR(50) not null,
                                             usuario_contrasenia NVARCHAR(50) not null,
                                             fecha_creacion DATE not null,
                                             nro_calle DECIMAL(18, 0) not null,
                                             piso_depto NVARCHAR(50) not null,
                                             localidad NVARCHAR(50) not null,
                                             provincia NVARCHAR(50) not null
);

CREATE TABLE CHIRIPIORCA.Detalle_de_factura (
                                                id DECIMAL(18, 0) PRIMARY KEY not null,
                                                publicacion DECIMAL(18, 0),
                                                concepto VARCHAR(50) not null,
                                                cantidad DECIMAL(18, 0) not null,
                                                subtotal DECIMAL(18, 0) not null,
                                                precio DECIMAL(18, 0) not null,
                                                FOREIGN KEY (publicacion) REFERENCES CHIRIPIORCA.Publicacion(codigo_de_publicacion)
);

CREATE TABLE CHIRIPIORCA.Facturacion (
                                         numero_de_factura DECIMAL(18, 0) PRIMARY KEY not null,
                                         detalle_factura DECIMAL(18, 0),
                                         fecha_de_la_factura DATE not null,
                                         importe_total DECIMAL(18, 0) not null,
                                         usuario_vendedor DECIMAL(18, 0),
                                         usuario_cliente DECIMAL(18, 0),
                                         FOREIGN KEY (detalle_factura) REFERENCES CHIRIPIORCA.Detalle_de_factura(id),
                                         FOREIGN KEY (usuario_vendedor) REFERENCES CHIRIPIORCA.Vendedor_usuario(id_vendedor_usuario),
                                         FOREIGN KEY (usuario_cliente) REFERENCES CHIRIPIORCA.Cliente_usuario(id_dni_usuario)
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
                                   id_dni_usuario DECIMAL(18, 0),
                                   FechaHora DATE not null,
                                   DetalleVenta DECIMAL(18, 0),
                                   Total DECIMAL(18, 0) not null,
                                   FOREIGN KEY (id_dni_usuario) REFERENCES CHIRIPIORCA.Cliente_usuario(id_dni_usuario),
                                   FOREIGN KEY (DetalleVenta) REFERENCES CHIRIPIORCA.Detalle_de_venta(id)
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
                                   FOREIGN KEY (cod_venta) REFERENCES CHIRIPIORCA.Venta(cod_venta)
);

CREATE TABLE CHIRIPIORCA.Tipo_envio(
                                        envio VARCHAR(30) PRIMARY KEY not null
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
                                     dni DECIMAL(18, 0) PRIMARY KEY NOT NULL,
                                     mail NVARCHAR(50) NOT NULL,
                                     nombre NVARCHAR(50) NOT NULL,
                                     apellido NVARCHAR(50) NOT NULL,
                                     ven_usuario DECIMAL(18, 0),  -- Asegúrate de incluir esta línea
                                     fecha_nacimiento DATE NOT NULL,
                                     FOREIGN KEY (ven_usuario) REFERENCES CHIRIPIORCA.Vendedor_usuario(id_vendedor_usuario)
);