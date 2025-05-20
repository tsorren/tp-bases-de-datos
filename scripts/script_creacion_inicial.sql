CREATE SCHEMA LOS_POLLOS_HERMANOS;
/*
ENTIDADES:

-- (1) Cliente
-- (2) Factura
-- (3) Sucursal
-- (4) Proveedor
-- (5) Ubicacion
-- (6) Compra
-- (7) DetallePedido
-- (8) Sillon
-- (9) Pedido
-- (10) Material
-- (11) Medida
-- (12) Modelo
-- (13) TipoMaterial
-- (14) Tela
-- (15) Madera
-- (16) Relleno
-- (17) DetalleCompra
-- (18) PedidoCancelacion
-- (19) Envio
-- (20) DetalleFactura
-- (21) MaterialPorSillon

*/

-- (1) Cliente
CREATE TABLE LOS_POLLOS_HERMANOS.Cliente (
    Cliente_Id BIGINT IDENTITY (1,1) NOT NULL,
    Cliente_Ubicacion BIGINT,
    Cliente_Dni BIGINT,
    Cliente_Nombre NVARCHAR(255),
    Cliente_Apellido NVARCHAR(255),
    Cliente_Fecha_Nacimiento DATETIME2(6),
    Cliente_Mail NVARCHAR(255),
    Cliente_Telefono NVARCHAR(255)
);

-- (2) Factura
CREATE TABLE LOS_POLLOS_HERMANOS.Factura (
    Factura_Numero BIGINT NOT NULL,
    Factura_Cliente BIGINT,
    Factura_Sucursal BIGINT,
	Factura_Fecha DATETIME2(6),
    Factura_Total DECIMAL(38,2)
);

-- (3) Sucursal
CREATE TABLE LOS_POLLOS_HERMANOS.Sucursal (
    Sucursal_Codigo BIGINT NOT NULL,
    Sucursal_Ubicacion BIGINT,
    Sucursal_Telefono NVARCHAR(255),
    Sucursal_Mail NVARCHAR(255)
);

-- (4) Proveedor
CREATE TABLE LOS_POLLOS_HERMANOS.Proveedor (
    Proveedor_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Proveedor_Ubicacion BIGINT,
    Proveedor_Cuit NVARCHAR(255),
    Proveedor_RazonSocial NVARCHAR(255),
    Proveedor_Telefono NVARCHAR(255),
    Proveedor_Mail NVARCHAR(255)
);

-- (5) Ubicacion
CREATE TABLE LOS_POLLOS_HERMANOS.Ubicacion (
    Ubicacion_Codigo BIGINT IDENTITY (1,1) NOT NULL,
    Ubicacion_Provincia NVARCHAR(255),
    Ubicacion_Localidad NVARCHAR(255),
    Ubicacion_Direccion NVARCHAR(255)
);

-- (6) Compra
CREATE TABLE LOS_POLLOS_HERMANOS.Compra (
    Compra_Numero DECIMAL(18,0) NOT NULL,
    Compra_Sucursal BIGINT,
    Compra_Proveedor BIGINT,
    Compra_Fecha DATETIME2(6),
    Compra_Total DECIMAL(18,2)
);

-- (7) DetallePedido
CREATE TABLE LOS_POLLOS_HERMANOS.DetallePedido (
    Detalle_Pedido_Numero BIGINT IDENTITY(1,1) NOT NULL,
    Detalle_Pedido_Sillon BIGINT,
    Detalle_Pedido_Pedido DECIMAL(18,0),
    Detalle_Pedido_Cantidad BIGINT,
    Detalle_Pedido_Precio DECIMAL(18,2),
    Detalle_Pedido_Subtotal DECIMAL(18,2)
);

-- (8) Sillon
CREATE TABLE LOS_POLLOS_HERMANOS.Sillon (
    Sillon_Codigo BIGINT NOT NULL,
    Sillon_Medida BIGINT,
    Sillon_Modelo BIGINT 
);

-- (9) Pedido
CREATE TABLE LOS_POLLOS_HERMANOS.Pedido (
    Pedido_Numero DECIMAL(18,0) NOT NULL,
    Pedido_Cliente BIGINT,
    Pedido_Sucursal BIGINT,
	Pedido_Fecha DATETIME2(6),
    Pedido_Total DECIMAL(18,2),	
    Pedido_Estado NVARCHAR(255)
);

-- (10) Material
CREATE TABLE LOS_POLLOS_HERMANOS.Material (
    Material_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Material_Tipo BIGINT, 
    Material_Nombre NVARCHAR(255),
    Material_Descripcion NVARCHAR(255),
    Material_Precio DECIMAL(38,2)
);

-- (11) Medida
CREATE TABLE LOS_POLLOS_HERMANOS.Medida (
    Medida_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Medida_Ancho DECIMAL(18,2),
    Medida_Alto DECIMAL(18,2),
    Medida_Profundidad DECIMAL(18,2),
    Medida_Precio DECIMAL(18,2)
);

-- (12) Modelo
CREATE TABLE LOS_POLLOS_HERMANOS.Modelo (
    Modelo_Codigo BIGINT NOT NULL,
    Modelo_Codigo_Numero NVARCHAR(255),
    Modelo_Descripcion NVARCHAR(255),
    Modelo_Precio_Base DECIMAL(18,2)
);

-- (13) TipoMaterial
CREATE TABLE LOS_POLLOS_HERMANOS.TipoMaterial (
    TipoMaterial_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    TipoMaterial_Tipo NVARCHAR(255)
);

-- (14) Tela
CREATE TABLE LOS_POLLOS_HERMANOS.Tela (
    Tela_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Tela_Color NVARCHAR(255),
    Tela_Textura NVARCHAR(255)
);

-- (15) Madera
CREATE TABLE LOS_POLLOS_HERMANOS.Madera (
    Madera_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Madera_Color NVARCHAR(255),
    Madera_Dureza NVARCHAR(255)
);

-- (16) Relleno
CREATE TABLE LOS_POLLOS_HERMANOS.Relleno (
    Relleno_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Relleno_Dureza DECIMAL(38,2)
);

-- (17) DetalleCompra
CREATE TABLE LOS_POLLOS_HERMANOS.DetalleCompra (
    Detalle_Compra_Numero BIGINT IDENTITY(1,1) NOT NULL,
    Detalle_Compra_Compra DECIMAL(18,0),
    Detalle_Compra_Material BIGINT,
    Detalle_Compra_Cantidad DECIMAL(18,0),
    Detalle_Compra_Precio DECIMAL(18,2),
    Detalle_Compra_Subtotal DECIMAL(18,2)
);

-- (18) PedidoCancelacion
CREATE TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion (
    Pedido_Cancelacion_Numero BIGINT IDENTITY(1,1) NOT NULL,
    Pedido_Cancelacion_Pedido DECIMAL(18,0),
    Pedido_Cancelacion_Fecha DATETIME2(6),
    Pedido_Cancelacion_Motivo VARCHAR(255)
);

-- (19) Envio
CREATE TABLE LOS_POLLOS_HERMANOS.Envio (
    Envio_Numero DECIMAL(18,0) NOT NULL,
    Envio_Factura BIGINT,
    Envio_Fecha_Programada DATETIME2(6),
    Envio_Fecha_Entrega DATETIME2(6),
    Envio_Importe_Traslado DECIMAL(18,2),
    Envio_Importe_Subida DECIMAL(18,2)
);

-- (20) DetalleFactura
CREATE TABLE LOS_POLLOS_HERMANOS.DetalleFactura (
    Detalle_Factura_Numero BIGINT IDENTITY(1,1) NOT NULL,
    Detalle_Factura_Factura BIGINT,
    Detalle_Factura_Detalle_Pedido BIGINT,
    Detalle_Factura_Cantidad DECIMAL(18,0),
    Detalle_Factura_Precio DECIMAL(18,2),
    Detalle_Factura_Subtotal DECIMAL(18,2)
);

-- (21) MaterialPorSillon
CREATE TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon (
    MaterialPorSillon_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    MaterialPorSillon_Material BIGINT,
    MaterialPorSillon_Sillon BIGINT 
);


/*
	-------------------------------------
		Constraints Primary Key
	------------------------------------
*/

-- (1) Cliente
ALTER TABLE LOS_POLLOS_HERMANOS.Cliente
ADD CONSTRAINT PK_Cliente PRIMARY KEY (Cliente_Id)

-- (2) Factura
ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT PK_Factura PRIMARY KEY (Factura_Numero)

-- (3) Sucursal
ALTER TABLE LOS_POLLOS_HERMANOS.Sucursal
ADD CONSTRAINT PK_Sucursal PRIMARY KEY (Sucursal_Codigo)

-- (4) Proveedor
ALTER TABLE LOS_POLLOS_HERMANOS.Proveedor
ADD CONSTRAINT PK_Proveedor PRIMARY KEY (Proveedor_Codigo)

-- (5) Ubicacion
ALTER TABLE LOS_POLLOS_HERMANOS.Ubicacion
ADD CONSTRAINT PK_Ubicacion PRIMARY KEY (Ubicacion_Codigo)

-- (6) Compra
ALTER TABLE LOS_POLLOS_HERMANOS.Compra
ADD CONSTRAINT PK_Compra PRIMARY KEY (Compra_Numero)

-- (7) DetallePedido
ALTER TABLE LOS_POLLOS_HERMANOS.DetallePedido
ADD CONSTRAINT PK_DetallePedido PRIMARY KEY (Detalle_Pedido_Numero)

-- (8) Sillon
ALTER TABLE LOS_POLLOS_HERMANOS.Sillon
ADD CONSTRAINT PK_Sillon PRIMARY KEY (Sillon_Codigo)

-- (9) Pedido
ALTER TABLE LOS_POLLOS_HERMANOS.Pedido
ADD CONSTRAINT PK_Pedido PRIMARY KEY (Pedido_Numero)

-- (10) Material
ALTER TABLE LOS_POLLOS_HERMANOS.Material
ADD CONSTRAINT PK_Material PRIMARY KEY (Material_Codigo)

-- (11) Medida
ALTER TABLE LOS_POLLOS_HERMANOS.Medida
ADD CONSTRAINT PK_Medida PRIMARY KEY (Medida_Codigo)

-- (12) Modelo
ALTER TABLE LOS_POLLOS_HERMANOS.Modelo
ADD CONSTRAINT PK_Modelo PRIMARY KEY (Modelo_Codigo)

-- (13) TipoMaterial
ALTER TABLE LOS_POLLOS_HERMANOS.TipoMaterial
ADD CONSTRAINT PK_TipoMaterial PRIMARY KEY (TipoMaterial_Codigo)

-- (14) Tela
ALTER TABLE LOS_POLLOS_HERMANOS.Tela
ADD CONSTRAINT PK_Tela PRIMARY KEY (Tela_Codigo)

-- (15) Madera
ALTER TABLE LOS_POLLOS_HERMANOS.Madera
ADD CONSTRAINT PK_Madera PRIMARY KEY (Madera_Codigo)

-- (16) Relleno
ALTER TABLE LOS_POLLOS_HERMANOS.Relleno
ADD CONSTRAINT PK_Relleno PRIMARY KEY (Relleno_Codigo)

-- (17) DetalleCompra
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT PK_DetalleCompra PRIMARY KEY (Detalle_Compra_Numero)

-- (18) PedidoCancelacion
ALTER TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion
ADD CONSTRAINT PK_PedidoCancelacion PRIMARY KEY (Pedido_Cancelacion_Numero)

-- (19) Envio
ALTER TABLE LOS_POLLOS_HERMANOS.Envio
ADD CONSTRAINT PK_Envio PRIMARY KEY (Envio_Numero)

-- (20) DetalleFactura
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleFactura
ADD CONSTRAINT PK_DetalleFactura PRIMARY KEY (Detalle_Factura_Numero)

-- (21) MaterialPorSillon
ALTER TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon
ADD CONSTRAINT PK_MaterialPorSillon PRIMARY KEY (MaterialPorSillon_Codigo)

/*
	-------------------------------------
		Constraints Foreign key
	------------------------------------
*/

-- (1) Cliente
ALTER TABLE LOS_POLLOS_HERMANOS.Cliente
ADD CONSTRAINT FK_Cliente_Ubicacion FOREIGN KEY (Cliente_Ubicacion) REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Codigo)

-- (2) Factura
ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT FK_Factura_Cliente FOREIGN KEY (Factura_Cliente) REFERENCES LOS_POLLOS_HERMANOS.Cliente(Cliente_Id)

ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT FK_Factura_Sucursal FOREIGN KEY (Factura_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo)

-- (3) Sucursal
ALTER TABLE LOS_POLLOS_HERMANOS.Sucursal
ADD CONSTRAINT FK_Sucursal_Ubicacion FOREIGN KEY (Sucursal_Ubicacion) REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Codigo)

-- (4) Proveedor
ALTER TABLE LOS_POLLOS_HERMANOS.Proveedor
ADD CONSTRAINT FK_Proveedor_Ubicacion FOREIGN KEY (Proveedor_Ubicacion) REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Codigo)

-- (5) Ubicacion
-- No tiene FK

-- (6) Compra
ALTER TABLE LOS_POLLOS_HERMANOS.Compra
ADD CONSTRAINT FK_Compra_Sucursal FOREIGN KEY (Compra_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo)

ALTER TABLE LOS_POLLOS_HERMANOS.Compra
ADD CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (Compra_Proveedor) REFERENCES LOS_POLLOS_HERMANOS.Proveedor(Proveedor_Codigo)

-- (7) DetallePedido
ALTER TABLE LOS_POLLOS_HERMANOS.DetallePedido
ADD CONSTRAINT FK_DetallePedido_Sillon FOREIGN KEY (Detalle_Pedido_Sillon) REFERENCES LOS_POLLOS_HERMANOS.Sillon(Sillon_Codigo)

ALTER TABLE LOS_POLLOS_HERMANOS.DetallePedido
ADD CONSTRAINT FK_DetallePedido_Pedido FOREIGN KEY (Detalle_Pedido_Pedido) REFERENCES LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero)

-- (8) Sillon
ALTER TABLE LOS_POLLOS_HERMANOS.Sillon
ADD CONSTRAINT FK_Sillon_Medida FOREIGN KEY (Sillon_Medida) REFERENCES LOS_POLLOS_HERMANOS.Medida(Medida_Codigo)

ALTER TABLE LOS_POLLOS_HERMANOS.Sillon
ADD CONSTRAINT FK_Sillon_Modelo FOREIGN KEY (Sillon_Modelo) REFERENCES LOS_POLLOS_HERMANOS.Modelo(Modelo_Codigo)

-- (9) Pedido
ALTER TABLE LOS_POLLOS_HERMANOS.Pedido
ADD CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (Pedido_Cliente) REFERENCES LOS_POLLOS_HERMANOS.Cliente(Cliente_Id)

ALTER TABLE LOS_POLLOS_HERMANOS.Pedido
ADD CONSTRAINT FK_Pedido_Sucursal FOREIGN KEY (Pedido_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo)

-- (10) Material
ALTER TABLE LOS_POLLOS_HERMANOS.Material
ADD CONSTRAINT FK_Material_TipoMaterial FOREIGN KEY (Material_Tipo) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

-- (11) Medida
-- No tiene FK

-- (12) Modelo
-- No tiene FK

-- (13) TipoMaterial
-- No tiene FK

-- (14) Tela
ALTER TABLE LOS_POLLOS_HERMANOS.Tela
ADD CONSTRAINT FK_Tela_TipoMaterial FOREIGN KEY (Tela_Codigo) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

-- (15) Madera
ALTER TABLE LOS_POLLOS_HERMANOS.Madera
ADD CONSTRAINT FK_Madera_TipoMaterial FOREIGN KEY (Madera_Codigo) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

-- (16) Relleno
ALTER TABLE LOS_POLLOS_HERMANOS.Relleno
ADD CONSTRAINT FK_Relleno_TipoMaterial FOREIGN KEY (Relleno_Codigo) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

-- (17) DetalleCompra
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT FK_DetalleCompra_Compra FOREIGN KEY (Detalle_Compra_Compra) REFERENCES LOS_POLLOS_HERMANOS.Compra(Compra_Numero)

ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT FK_DetalleCompra_Material FOREIGN KEY (Detalle_Compra_Material) REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo)

-- (18) PedidoCancelacion
ALTER TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion
ADD CONSTRAINT FK_PedidoCancelacion_Pedido FOREIGN KEY (Pedido_Cancelacion_Pedido) REFERENCES LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero)

-- (19) Envio
ALTER TABLE LOS_POLLOS_HERMANOS.Envio
ADD CONSTRAINT FK_Envio_Factura FOREIGN KEY (Envio_Factura) REFERENCES LOS_POLLOS_HERMANOS.Factura(Factura_Numero)

-- (20) DetalleFactura
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleFactura
ADD CONSTRAINT FK_DetalleFactura_Factura FOREIGN KEY (Detalle_Factura_Factura) REFERENCES LOS_POLLOS_HERMANOS.Factura(Factura_Numero)

ALTER TABLE LOS_POLLOS_HERMANOS.DetalleFactura
ADD CONSTRAINT FK_DetalleFactura_DetallePedido FOREIGN KEY (Detalle_Factura_Detalle_Pedido) REFERENCES LOS_POLLOS_HERMANOS.DetallePedido(Detalle_Pedido_Numero)

-- (21) MaterialPorSillon
ALTER TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon
ADD CONSTRAINT FK_MaterialPorSillon_Material FOREIGN KEY (MaterialPorSillon_Material) REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo)

ALTER TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon
ADD CONSTRAINT FK_MaterialPorSillon_Sillon FOREIGN KEY (MaterialPorSillon_Sillon) REFERENCES LOS_POLLOS_HERMANOS.Sillon(Sillon_Codigo)

/*
	----------------------------------------------------------------------------------------------
									Migraci�n de Ubicacion
			(Tiene que hacerse antes que la migraci�n de Cliente, Proveedor y Sucursal)
	---------------------------------------------------------------------------------------------
*/
-- (5) Ubicacion 
INSERT INTO LOS_POLLOS_HERMANOS.Ubicacion (Ubicacion_Provincia, Ubicacion_Localidad, Ubicacion_Direccion)
SELECT DISTINCT Sucursal_Provincia, Sucursal_Localidad, Sucursal_Direccion
FROM gd_esquema.Maestra
WHERE Sucursal_Provincia IS NOT NULL
UNION
SELECT DISTINCT Cliente_Provincia, Cliente_Localidad, Cliente_Direccion
FROM gd_esquema.Maestra
WHERE Cliente_Provincia IS NOT NULL
UNION
SELECT DISTINCT Proveedor_Provincia, Proveedor_Localidad, Proveedor_Direccion
FROM gd_esquema.Maestra
WHERE Proveedor_Provincia IS NOT NULL;

-- Comprobaci�n de que se migraron todas las ubicaciones
-- cantidad de filas de ubicacion migradas:
select count(*) as ubicaciones_migradas from LOS_POLLOS_HERMANOS.Ubicacion;
-- cantidad de filas �nicas en tabla maestra:

select count(distinct sucursal_localidad+sucursal_direccion+sucursal_provincia)
from gd_esquema.maestra
select count(distinct proveedor_localidad+proveedor_direccion+proveedor_provincia)
from gd_esquema.maestra
select count(distinct cliente_localidad+cliente_direccion+cliente_provincia)
from gd_esquema.maestra

/*
	----------------------------------------------
				Migraci�n de Cliente
	----------------------------------------------
*/
BEGIN TRANSACTION;
-- (1) Cliente
INSERT INTO LOS_POLLOS_HERMANOS.Cliente (Cliente_Ubicacion, Cliente_Dni, Cliente_Nombre, Cliente_Apellido, Cliente_Fecha_Nacimiento, Cliente_Mail, Cliente_Telefono)
SELECT DISTINCT
    u.Ubicacion_Codigo, m.Cliente_Dni, m.Cliente_Nombre, m.Cliente_Apellido, m.Cliente_FechaNacimiento, m.Cliente_Mail, m.Cliente_Telefono
FROM gd_esquema.Maestra m
JOIN LOS_POLLOS_HERMANOS.Ubicacion u ON 
    u.Ubicacion_Provincia = m.Cliente_Provincia  
    AND u.Ubicacion_Localidad = m.Cliente_Localidad  
    AND u.Ubicacion_Direccion = m.Cliente_Direccion
order by m.Cliente_Dni

ROLLBACK;
-- Comprobaci�n de que se migraron todos los clientes:
-- cantidad migradas:
SELECT COUNT (*) as clientes_migrados FROM LOS_POLLOS_HERMANOS.Cliente
-- cantidad en tabla maestra:
SELECT COUNT(*) as clientes_en_tabla_maestra
FROM (
    SELECT DISTINCT 
        m.Cliente_DNI, m.Cliente_Nombre, m.Cliente_Apellido, m.Cliente_FechaNacimiento, m.Cliente_Mail, m.Cliente_Telefono, m.Cliente_Provincia, m.Cliente_Localidad, m.Cliente_Direccion
    FROM gd_esquema.Maestra m
    WHERE m.Cliente_Provincia IS NOT NULL
        AND m.Cliente_Localidad IS NOT NULL
        AND m.Cliente_Direccion IS NOT NULL
) AS cantidad_de_clientes;

/*
	----------------------------------------------
				Migraci�n de Sucursal
	----------------------------------------------
*/
BEGIN TRANSACTION;
-- (3) Sucursal
INSERT INTO LOS_POLLOS_HERMANOS.Sucursal (
    Sucursal_Codigo, Sucursal_Ubicacion, Sucursal_Telefono, Sucursal_Mail
)
SELECT DISTINCT
    m.Sucursal_NroSucursal,
    u.Ubicacion_Codigo,
    m.Sucursal_Telefono,
    m.Sucursal_Mail
FROM gd_esquema.Maestra m
JOIN LOS_POLLOS_HERMANOS.Ubicacion u ON
    u.Ubicacion_Provincia = m.Sucursal_Provincia
    AND u.Ubicacion_Localidad = m.Sucursal_Localidad
    AND u.Ubicacion_Direccion = m.Sucursal_Direccion;

ROLLBACK;
-- Comprobaci�n de que se migraron todas las sucursales:
-- cantidad de sucursales distintas en la tabla maestra:
SELECT COUNT(DISTINCT Sucursal_NroSucursal) as sucursales_en_tabla_maestra FROM gd_esquema.Maestra;
-- cantidad de sucursales migradas:
select count(*) sucursales_migradas from LOS_POLLOS_HERMANOS.Sucursal;		

/*
	----------------------------------------------
				Migraci�n de Proveedor
	----------------------------------------------
*/
BEGIN TRANSACTION;
-- (4) Proveedor
INSERT INTO LOS_POLLOS_HERMANOS.Proveedor (Proveedor_Ubicacion, Proveedor_Cuit, Proveedor_RazonSocial, Proveedor_Telefono, Proveedor_Mail)
SELECT DISTINCT
    u.Ubicacion_Codigo,
    m.Proveedor_Cuit,
    m.Proveedor_RazonSocial,
    m.Proveedor_Telefono,
    m.Proveedor_Mail
FROM gd_esquema.Maestra m
JOIN LOS_POLLOS_HERMANOS.Ubicacion u ON 
    u.Ubicacion_Provincia = m.Proveedor_Provincia  
    AND u.Ubicacion_Localidad = m.Proveedor_Localidad  
    AND u.Ubicacion_Direccion = m.Proveedor_Direccion;
ROLLBACK;
-- Comprobaci�n de que se migraron todos los proveedores:
-- cantidad migradas:
select count(*) as proveedores_migrados from LOS_POLLOS_HERMANOS.Proveedor;
-- cantidad en la tabla maestra:
SELECT count(*) as proveedores_en_tabla_maestra
FROM (
    SELECT DISTINCT
        u.Ubicacion_Codigo, m.Proveedor_CUIT, m.Proveedor_RazonSocial, m.Proveedor_Telefono, m.Proveedor_Mail
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.Ubicacion u ON 
        u.Ubicacion_Provincia = m.Proveedor_Provincia  
        AND u.Ubicacion_Localidad = m.Proveedor_Localidad  
        AND u.Ubicacion_Direccion = m.Proveedor_Direccion
) AS cantidad_de_proveedores;

/*
------------------------------------------------------
                Migraci�n de Medida    
------------------------------------------------------
*/

-- (11) Medida
INSERT INTO LOS_POLLOS_HERMANOS.Medida (Medida_Ancho, Medida_Alto, Medida_Profundidad, Medida_Precio)
SELECT DISTINCT m.Sillon_Medida_Ancho, m.Sillon_Medida_Alto, m.Sillon_Medida_Profundidad, m.Sillon_Medida_Precio
FROM gd_esquema.maestra m
WHERE m.Sillon_Medida_Alto IS NOT NULL

/*
------------------------------------------------------
                Migraci�n de Modelo
------------------------------------------------------
*/

-- (12) Modelo
INSERT INTO LOS_POLLOS_HERMANOS.Modelo (Modelo_Codigo, Modelo_Codigo_Numero, Modelo_Descripcion, Modelo_Precio_Base)
SELECT DISTINCT m.Sillon_Modelo_Codigo, m.Sillon_Modelo, m.Sillon_Modelo_Descripcion, m.Sillon_Modelo_Precio
FROM gd_esquema.Maestra m
WHERE m.Sillon_Modelo_Codigo IS NOT NULL

/*
------------------------------------------------------
                Migraci�n de Sillon
------------------------------------------------------
*/

-- (8) Sillon
INSERT INTO LOS_POLLOS_HERMANOS.Sillon(Sillon_Codigo, Sillon_Medida, Sillon_Modelo)
SELECT DISTINCT m.Sillon_Codigo, u1.Medida_Codigo, u2.Modelo_Codigo
FROM gd_esquema.Maestra m
JOIN LOS_POLLOS_HERMANOS.Medida u1 ON
    m.Sillon_Medida_Alto = u1.Medida_Alto 
    AND m.Sillon_Medida_Ancho = u1.Medida_Ancho 
    AND m.Sillon_Medida_Precio = u1.Medida_Precio 
    AND m.Sillon_Medida_Profundidad = u1.Medida_Profundidad                          
JOIN LOS_POLLOS_HERMANOS.Modelo u2 ON 
    u2.Modelo_Codigo = m.Sillon_Modelo_Codigo

/*
------------------------------------------------------
                Migraci�n de Compra
------------------------------------------------------
*/
-- (6) Compra
INSERT INTO LOS_POLLOS_HERMANOS.Compra(Compra_Numero, Compra_Sucursal, Compra_Proveedor, Compra_Fecha, Compra_Total)
SELECT DISTINCT m.Compra_Numero, s.Sucursal_Codigo, p.Proveedor_Codigo, m.Compra_Fecha, m.Compra_Total
FROM gd_esquema.Maestra m
JOIN LOS_POLLOS_HERMANOS.Sucursal s ON s.Sucursal_Codigo = m.Sucursal_NroSucursal
JOIN LOS_POLLOS_HERMANOS.Proveedor p ON p.Proveedor_Cuit = m.Proveedor_Cuit and p.Proveedor_RazonSocial = m.Proveedor_RazonSocial


/*
------------------------------------------------------
                Migraci�n de Factura
------------------------------------------------------
*/
-- (2) Factura

INSERT INTO LOS_POLLOS_HERMANOS.Factura(Factura_Numero, Factura_Cliente, Factura_Sucursal, Factura_Fecha, Factura_Total)
SELECT DISTINCT m.Factura_Numero, c.Cliente_Id, s.Sucursal_Codigo, m.Factura_Fecha, m.Factura_Total
FROM gd_esquema.Maestra m
JOIN LOS_POLLOS_HERMANOS.Cliente c ON m.Cliente_Dni = c.Cliente_Dni AND m.Cliente_Apellido = c.Cliente_Apellido AND m.Cliente_Nombre = c.Cliente_Nombre
JOIN LOS_POLLOS_HERMANOS.Sucursal s ON m.Sucursal_NroSucursal = s.Sucursal_Codigo
WHERE m.Factura_Numero IS NOT NULL

/*
------------------------------------------------------
                Migraci�n de Pedido
------------------------------------------------------
*/
-- (9) Pedido
INSERT INTO LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero, Pedido_Cliente, Pedido_Sucursal, Pedido_Fecha, Pedido_Total, Pedido_Estado)
SELECT DISTINCT m.Pedido_Numero, c.Cliente_Id, s.Sucursal_Codigo, m.Pedido_Fecha, m.Pedido_Total, m.Pedido_Estado
FROM gd_esquema.Maestra m
JOIN LOS_POLLOS_HERMANOS.Cliente c ON m.Cliente_Dni = c.Cliente_Dni and m.Cliente_Nombre = c.Cliente_Nombre and m.Cliente_Apellido = m.Cliente_Apellido
JOIN LOS_POLLOS_HERMANOS.Sucursal s ON m.Sucursal_NroSucursal = s.Sucursal_Codigo
WHERE m.Pedido_Numero IS NOT NULL

/*
------------------------------------------------------
                Migraci�n de DetallePedido
------------------------------------------------------
*/
-- (7) DetallePedido
INSERT INTO LOS_POLLOS_HERMANOS.DetallePedido(Detalle_Pedido_Sillon, Detalle_Pedido_Pedido, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_Subtotal)
SELECT DISTINCT m.Sillon_Codigo, m.Pedido_Numero, m.Detalle_Pedido_Cantidad, m.Detalle_Pedido_Precio, m.Detalle_Pedido_Subtotal
FROM gd_esquema.Maestra m
WHERE m.Sillon_Codigo IS NOT NULL

/*
------------------------------------------------------
                Migraci�n de DetallePedido
------------------------------------------------------
*/
-- (18) PedidoCancelacion
INSERT INTO LOS_POLLOS_HERMANOS.PedidoCancelacion(Pedido_Cancelacion_Pedido, Pedido_Cancelacion_Fecha, Pedido_Cancelacion_Motivo)
SELECT DISTINCT m.Pedido_Numero, m.Pedido_Cancelacion_Fecha, m.Pedido_Cancelacion_Motivo
FROM gd_esquema.Maestra m
WHERE m.Pedido_Cancelacion_Fecha IS NOT NULL


/*
------------------------------------------------------
                Migraci�n de Envio
------------------------------------------------------
*/
-- (19) Envio
INSERT INTO LOS_POLLOS_HERMANOS.Envio(Envio_Numero, Envio_Factura, Envio_Fecha_Programada, Envio_Fecha_Entrega, Envio_Importe_Traslado, Envio_Importe_Subida)
SELECT DISTINCT m.Envio_Numero, m.Factura_Numero, m.Envio_Fecha_Programada, m.Envio_Fecha, m.Envio_ImporteTraslado, m.Envio_ImporteSubida
FROM gd_esquema.Maestra m
WHERE m.Envio_Numero IS NOT NULL