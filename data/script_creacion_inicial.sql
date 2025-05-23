USE GD1C2025
GO
CREATE SCHEMA LOS_POLLOS_HERMANOS;
GO
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
    TipoMaterial_Tipo NVARCHAR(255),
    TipoMaterial_Nombre NVARCHAR(255),
    TipoMaterial_Descripcion NVARCHAR(255)
);

-- (14) Tela
CREATE TABLE LOS_POLLOS_HERMANOS.Tela (
    Tela_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Tela_Material BIGINT,
    Tela_Color NVARCHAR(255),
    Tela_Textura NVARCHAR(255)
);

-- (15) Madera
CREATE TABLE LOS_POLLOS_HERMANOS.Madera (
    Madera_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Madera_Material BIGINT,
    Madera_Color NVARCHAR(255),
    Madera_Dureza NVARCHAR(255)
);

-- (16) Relleno
CREATE TABLE LOS_POLLOS_HERMANOS.Relleno (
    Relleno_Codigo BIGINT IDENTITY(1,1) NOT NULL,
    Relleno_Material BIGINT,
    Relleno_Densidad DECIMAL(38,2)
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
ADD CONSTRAINT FK_Factura_Cliente FOREIGN KEY (Factura_Cliente) REFERENCES LOS_POLLOS_HERMANOS.Cliente(Cliente_Id),
	CONSTRAINT FK_Factura_Sucursal FOREIGN KEY (Factura_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo)

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
ADD CONSTRAINT FK_Compra_Sucursal FOREIGN KEY (Compra_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo),
	CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (Compra_Proveedor) REFERENCES LOS_POLLOS_HERMANOS.Proveedor(Proveedor_Codigo)

-- (7) DetallePedido
ALTER TABLE LOS_POLLOS_HERMANOS.DetallePedido
ADD CONSTRAINT FK_DetallePedido_Sillon FOREIGN KEY (Detalle_Pedido_Sillon) REFERENCES LOS_POLLOS_HERMANOS.Sillon(Sillon_Codigo),
	CONSTRAINT FK_DetallePedido_Pedido FOREIGN KEY (Detalle_Pedido_Pedido) REFERENCES LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero)

-- (8) Sillon
ALTER TABLE LOS_POLLOS_HERMANOS.Sillon
ADD CONSTRAINT FK_Sillon_Medida FOREIGN KEY (Sillon_Medida) REFERENCES LOS_POLLOS_HERMANOS.Medida(Medida_Codigo),
	CONSTRAINT FK_Sillon_Modelo FOREIGN KEY (Sillon_Modelo) REFERENCES LOS_POLLOS_HERMANOS.Modelo(Modelo_Codigo)

-- (9) Pedido
ALTER TABLE LOS_POLLOS_HERMANOS.Pedido
ADD CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (Pedido_Cliente) REFERENCES LOS_POLLOS_HERMANOS.Cliente(Cliente_Id),
	CONSTRAINT FK_Pedido_Sucursal FOREIGN KEY (Pedido_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo)

-- (10) Material
ALTER TABLE LOS_POLLOS_HERMANOS.Material
ADD CONSTRAINT FK_Material_TipoMaterial FOREIGN KEY (Material_Tipo) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

-- (11) Medida
-- No tiene FK
ALTER TABLE LOS_POLLOS_HERMANOS.Medida
ADD CONSTRAINT CK_Medida_Valores CHECK (Medida_Ancho > 0 AND Medida_Alto > 0 AND Medida_Profundidad > 0 AND Medida_Precio >= 0)

-- (12) Modelo
-- No tiene FK
ALTER TABLE LOS_POLLOS_HERMANOS.Modelo
ADD CONSTRAINT CK_Modelo_PrecioBase CHECK (Modelo_Precio_Base >= 0)

-- (13) TipoMaterial
-- No tiene FK

-- (14) Tela
ALTER TABLE LOS_POLLOS_HERMANOS.Tela
ADD CONSTRAINT FK_Tela_Material FOREIGN KEY (Tela_Material) REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo)

-- (15) Madera
ALTER TABLE LOS_POLLOS_HERMANOS.Madera
ADD CONSTRAINT FK_Madera_Material FOREIGN KEY (Madera_Material) REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo)

-- (16) Relleno
ALTER TABLE LOS_POLLOS_HERMANOS.Relleno
ADD CONSTRAINT FK_Relleno_Material FOREIGN KEY (Relleno_Material) REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo)

-- (17) DetalleCompra
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT FK_DetalleCompra_Compra FOREIGN KEY (Detalle_Compra_Compra) REFERENCES LOS_POLLOS_HERMANOS.Compra(Compra_Numero),
	CONSTRAINT FK_DetalleCompra_Material FOREIGN KEY (Detalle_Compra_Material) REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo)

-- (18) PedidoCancelacion
ALTER TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion
ADD CONSTRAINT FK_PedidoCancelacion_Pedido FOREIGN KEY (Pedido_Cancelacion_Pedido) REFERENCES LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero)

-- (19) Envio
ALTER TABLE LOS_POLLOS_HERMANOS.Envio
ADD CONSTRAINT FK_Envio_Factura FOREIGN KEY (Envio_Factura) REFERENCES LOS_POLLOS_HERMANOS.Factura(Factura_Numero)

-- (20) DetalleFactura
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleFactura
ADD CONSTRAINT FK_DetalleFactura_Factura FOREIGN KEY (Detalle_Factura_Factura) REFERENCES LOS_POLLOS_HERMANOS.Factura(Factura_Numero),
	CONSTRAINT FK_DetalleFactura_DetallePedido FOREIGN KEY (Detalle_Factura_Detalle_Pedido) REFERENCES LOS_POLLOS_HERMANOS.DetallePedido(Detalle_Pedido_Numero)

-- (21) MaterialPorSillon
ALTER TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon
ADD CONSTRAINT FK_MaterialPorSillon_Material FOREIGN KEY (MaterialPorSillon_Material) REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo),
	CONSTRAINT FK_MaterialPorSillon_Sillon FOREIGN KEY (MaterialPorSillon_Sillon) REFERENCES LOS_POLLOS_HERMANOS.Sillon(Sillon_Codigo)

GO

/*
----------------------------------------------
		        Migracion de Ubicacion
----------------------------------------------
*/
-- (5) Ubicacion
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Ubicacion
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Ubicacion (Ubicacion_Provincia, Ubicacion_Localidad, Ubicacion_Direccion)
	SELECT DISTINCT Sucursal_Provincia, Sucursal_Localidad, Sucursal_Direccion
	FROM gd_esquema.Maestra
	WHERE Sucursal_Provincia IS NOT NULL
	AND NOT EXISTS (	-- no lo vuelve a insertar si se ejecuta de vuelta el exec procedure y ya está migrado
		SELECT * FROM LOS_POLLOS_HERMANOS.Ubicacion u
		WHERE u.Ubicacion_Provincia = Sucursal_Provincia AND u.Ubicacion_Localidad = Sucursal_Localidad AND u.Ubicacion_Direccion = Sucursal_Direccion
	)
	UNION
	SELECT DISTINCT Cliente_Provincia, Cliente_Localidad, Cliente_Direccion
	FROM gd_esquema.Maestra
	WHERE Cliente_Provincia IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Ubicacion u
		WHERE u.Ubicacion_Provincia = Cliente_Provincia AND u.Ubicacion_Localidad = Cliente_Localidad AND u.Ubicacion_Direccion = Cliente_Direccion
	)
	UNION
	SELECT DISTINCT Proveedor_Provincia, Proveedor_Localidad, Proveedor_Direccion
	FROM gd_esquema.Maestra
	WHERE Proveedor_Provincia IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Ubicacion u
		WHERE u.Ubicacion_Provincia = Proveedor_Provincia AND u.Ubicacion_Localidad = Proveedor_Localidad AND u.Ubicacion_Direccion = Proveedor_Direccion
	);
END
GO

/*
----------------------------------------------
				Migracion de Cliente
----------------------------------------------
*/
-- (1) Cliente
GO
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Cliente
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Cliente (Cliente_Ubicacion, Cliente_Dni, Cliente_Nombre, Cliente_Apellido, Cliente_Fecha_Nacimiento, Cliente_Mail, Cliente_Telefono)
	SELECT DISTINCT
		u.Ubicacion_Codigo, m.Cliente_Dni, m.Cliente_Nombre, m.Cliente_Apellido, m.Cliente_FechaNacimiento, m.Cliente_Mail, m.Cliente_Telefono
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.Ubicacion u ON 
		u.Ubicacion_Provincia = m.Cliente_Provincia  
		AND u.Ubicacion_Localidad = m.Cliente_Localidad  
		AND u.Ubicacion_Direccion = m.Cliente_Direccion
	WHERE NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Cliente C WHERE C.Cliente_Dni = M.Cliente_Dni
	);
END
GO

/*
----------------------------------------------
				Migracion de Sucursal
----------------------------------------------
*/
-- (3) Sucursal
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Sucursal
AS
BEGIN
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
		AND u.Ubicacion_Direccion = m.Sucursal_Direccion
	WHERE NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Sucursal s
		WHERE s.Sucursal_Codigo = m.Sucursal_NroSucursal
	);
END
GO

/*
----------------------------------------------
				Migracion de Proveedor
----------------------------------------------
*/
-- (4) Proveedor
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Proveedor
AS
BEGIN
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
		AND u.Ubicacion_Direccion = m.Proveedor_Direccion
	WHERE NOT EXISTS (SELECT * FROM LOS_POLLOS_HERMANOS.Proveedor p WHERE p.Proveedor_Cuit = m.Proveedor_Cuit)
END
GO
/*
------------------------------------------------------
                Migracion de Medida    
------------------------------------------------------
*/
-- (11) Medida

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Medida
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Medida (Medida_Ancho, Medida_Alto, Medida_Profundidad, Medida_Precio)
	SELECT DISTINCT m.Sillon_Medida_Ancho, m.Sillon_Medida_Alto, m.Sillon_Medida_Profundidad, m.Sillon_Medida_Precio
	FROM gd_esquema.maestra m
	WHERE m.Sillon_Medida_Alto IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Medida med
		WHERE med.Medida_Ancho = m.Sillon_Medida_Ancho AND med.Medida_Alto = m.Sillon_Medida_Alto AND med.Medida_Profundidad = m.Sillon_Medida_Profundidad AND med.Medida_Precio = m.Sillon_Medida_Precio
	)
END
GO
/*
------------------------------------------------------
                Migracion de Modelo
------------------------------------------------------
*/
-- (12) Modelo

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Modelo
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Modelo (Modelo_Codigo, Modelo_Codigo_Numero, Modelo_Descripcion, Modelo_Precio_Base)
	SELECT DISTINCT m.Sillon_Modelo_Codigo, m.Sillon_Modelo, m.Sillon_Modelo_Descripcion, m.Sillon_Modelo_Precio
	FROM gd_esquema.Maestra m
	WHERE m.Sillon_Modelo_Codigo IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Modelo mo
		WHERE mo.Modelo_Codigo = m.Sillon_Modelo_Codigo AND mo.Modelo_Codigo_Numero = m.Sillon_Modelo
	);
END
GO
/*
------------------------------------------------------
                Migracion de Sillon
------------------------------------------------------
*/
-- (8) Sillon

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Sillon
AS
BEGIN
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
	WHERE NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Sillon s
		WHERE s.Sillon_Codigo = m.Sillon_Codigo
	);
END
GO
/*
------------------------------------------------------
                Migracion de Compra
------------------------------------------------------
*/
-- (6) Compra

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Compra
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Compra(Compra_Numero, Compra_Sucursal, Compra_Proveedor, Compra_Fecha, Compra_Total)
	SELECT DISTINCT m.Compra_Numero, s.Sucursal_Codigo, p.Proveedor_Codigo, m.Compra_Fecha, m.Compra_Total
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.Sucursal s ON s.Sucursal_Codigo = m.Sucursal_NroSucursal
	JOIN LOS_POLLOS_HERMANOS.Proveedor p ON p.Proveedor_Cuit = m.Proveedor_Cuit AND p.Proveedor_RazonSocial = m.Proveedor_RazonSocial
	WHERE NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Compra c
		WHERE c.Compra_Numero = m.Compra_Numero
	);
END
GO
/*
------------------------------------------------------
                Migracion de Factura
------------------------------------------------------
*/
-- (2) Factura

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Factura
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Factura(Factura_Numero, Factura_Cliente, Factura_Sucursal, Factura_Fecha, Factura_Total)
	SELECT DISTINCT m.Factura_Numero, c.Cliente_Id, s.Sucursal_Codigo, m.Factura_Fecha, m.Factura_Total
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.Cliente c ON m.Cliente_Dni = c.Cliente_Dni AND m.Cliente_Apellido = c.Cliente_Apellido AND m.Cliente_Nombre = c.Cliente_Nombre
	JOIN LOS_POLLOS_HERMANOS.Sucursal s ON m.Sucursal_NroSucursal = s.Sucursal_Codigo
	WHERE m.Factura_Numero IS NOT NULL
	AND NOT EXISTS (SELECT * FROM LOS_POLLOS_HERMANOS.Factura f WHERE f.Factura_Numero = m.Factura_Numero);
END
GO

/*
------------------------------------------------------
                Migracion de Pedido
------------------------------------------------------
*/
-- (9) Pedido
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Pedido
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero, Pedido_Cliente, Pedido_Sucursal, Pedido_Fecha, Pedido_Total, Pedido_Estado)
	SELECT DISTINCT m.Pedido_Numero, c.Cliente_Id, s.Sucursal_Codigo, m.Pedido_Fecha, m.Pedido_Total, m.Pedido_Estado
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.Cliente c ON m.Cliente_Dni = c.Cliente_Dni and m.Cliente_Nombre = c.Cliente_Nombre and m.Cliente_Apellido = m.Cliente_Apellido
	JOIN LOS_POLLOS_HERMANOS.Sucursal s ON m.Sucursal_NroSucursal = s.Sucursal_Codigo
	WHERE m.Pedido_Numero IS NOT NULL
	AND NOT EXISTS (SELECT * FROM LOS_POLLOS_HERMANOS.Pedido p WHERE p.Pedido_Numero = m.Pedido_Numero)
END
GO
/*
------------------------------------------------------
                Migracion de DetallePedido
------------------------------------------------------
*/
-- (7) DetallePedido

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_DetallePedido
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.DetallePedido(Detalle_Pedido_Sillon, Detalle_Pedido_Pedido, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_Subtotal)
	SELECT DISTINCT m.Sillon_Codigo, m.Pedido_Numero, m.Detalle_Pedido_Cantidad, m.Detalle_Pedido_Precio, m.Detalle_Pedido_Subtotal
	FROM gd_esquema.Maestra m
	WHERE m.Sillon_Codigo IS NOT NULL
	AND NOT EXISTS (SELECT * FROM LOS_POLLOS_HERMANOS.DetallePedido dp WHERE dp.Detalle_Pedido_Sillon = m.Sillon_Codigo)
END
GO
/*
------------------------------------------------------
                Migracion de PedidoCancelacion
------------------------------------------------------
*/
-- (18) PedidoCancelacion

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_PedidoCancelacion
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.PedidoCancelacion(Pedido_Cancelacion_Pedido, Pedido_Cancelacion_Fecha, Pedido_Cancelacion_Motivo)
	SELECT DISTINCT m.Pedido_Numero, m.Pedido_Cancelacion_Fecha, m.Pedido_Cancelacion_Motivo
	FROM gd_esquema.Maestra m
	WHERE m.Pedido_Cancelacion_Fecha IS NOT NULL
	AND NOT EXISTS (SELECT * FROM LOS_POLLOS_HERMANOS.PedidoCancelacion pc WHERE pc.Pedido_Cancelacion_Pedido = m.Pedido_Numero	);
END
GO
/*
------------------------------------------------------
                Migracion de Envio
------------------------------------------------------
*/
-- (19) Envio

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Envio
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Envio(Envio_Numero, Envio_Factura, Envio_Fecha_Programada, Envio_Fecha_Entrega, Envio_Importe_Traslado, Envio_Importe_Subida)
	SELECT DISTINCT m.Envio_Numero, m.Factura_Numero, m.Envio_Fecha_Programada, m.Envio_Fecha, m.Envio_ImporteTraslado, m.Envio_ImporteSubida
	FROM gd_esquema.Maestra m
	WHERE m.Envio_Numero IS NOT NULL
	AND NOT EXISTS ( SELECT * FROM LOS_POLLOS_HERMANOS.Envio e WHERE e.Envio_Numero = m.Envio_Numero	);
END
GO
/*
------------------------------------------------------
                Migracion de DetalleFactura
------------------------------------------------------
*/
-- (20) DetalleFactura
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_DetalleFactura
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.DetalleFactura (Detalle_Factura_Factura, Detalle_Factura_Detalle_Pedido, Detalle_Factura_Cantidad, Detalle_Factura_Precio, Detalle_Factura_Subtotal)
	SELECT m.Factura_Numero, dp.Detalle_Pedido_Numero, m.Detalle_Factura_Cantidad, m.Detalle_Factura_Precio, m.Detalle_Factura_Subtotal
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.Factura f ON m.Factura_Numero = f.Factura_Numero
	JOIN (SELECT MIN(Detalle_Pedido_Numero) AS Detalle_Pedido_Numero, Detalle_Pedido_Pedido, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_Subtotal
	FROM LOS_POLLOS_HERMANOS.DetallePedido 
	GROUP BY Detalle_Pedido_Pedido, Detalle_Pedido_Cantidad, Detalle_Pedido_Precio, Detalle_Pedido_Subtotal) dp -- uso subselect dentro del join porque hay filas con valores repetidos
	ON dp.Detalle_Pedido_Pedido = m.Pedido_Numero
	AND dp.Detalle_Pedido_Cantidad = m.Detalle_Factura_Cantidad
	AND dp.Detalle_Pedido_Precio = m.Detalle_Factura_Precio
	AND dp.Detalle_Pedido_Subtotal = m.Detalle_Factura_Subtotal
	WHERE m.Detalle_Factura_Precio IS NOT NULL
	AND m.Detalle_Factura_Cantidad IS NOT NULL
	AND m.Detalle_Factura_Subtotal IS NOT NULL
	AND m.Pedido_Numero IS NOT NULL
	AND NOT EXISTS (SELECT * FROM LOS_POLLOS_HERMANOS.DetalleFactura df WHERE df.Detalle_Factura_Factura = m.Factura_Numero)
END
GO
/*
------------------------------------------------------
                Migracion de TipoMaterial
------------------------------------------------------
*/
-- (13) TipoMaterial
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_TipoMaterial
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Tipo, TipoMaterial_Nombre, TipoMaterial_Descripcion)
	SELECT DISTINCT m.Material_Tipo, m.Material_Nombre, m.Material_Descripcion
	FROM gd_esquema.Maestra m
	WHERE m.material_tipo IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.TipoMaterial tm WHERE tm.TipoMaterial_Tipo = m.Material_Tipo
        AND tm.TipoMaterial_Nombre = m.Material_Nombre AND tm.TipoMaterial_Descripcion = m.Material_Descripcion
      );
END
GO

/*
------------------------------------------------------
                Migracion de Material
------------------------------------------------------
*/
-- (10) Material

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Material
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Material(Material_Tipo, Material_Precio)
	SELECT DISTINCT u.TipoMaterial_Codigo, m.Material_Precio
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.TipoMaterial u ON u.TipoMaterial_Tipo = m.Material_Tipo AND u.TipoMaterial_Nombre = m.Material_Nombre AND u.TipoMaterial_Descripcion = m.Material_Descripcion
	WHERE NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Material mat
		WHERE mat.Material_Tipo = u.TipoMaterial_Codigo AND mat.Material_Precio = m.Material_Precio
	);
END
GO
/*
------------------------------------------------------
                Migracion de MaterialPorSillon
------------------------------------------------------
*/
-- (21) MaterialPorSillon

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_MaterialPorSillon
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.MaterialPorSillon(MaterialPorSillon_Material, MaterialPorSillon_Sillon)
	SELECT u2.Material_Codigo, m.Sillon_Codigo
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.TipoMaterial u1 ON u1.TipoMaterial_Tipo = m.Material_Tipo AND u1.TipoMaterial_Nombre = m.Material_Nombre AND u1.TipoMaterial_Descripcion = m.Material_Descripcion
	JOIN LOS_POLLOS_HERMANOS.Material u2 ON u2.Material_Tipo = u1.TipoMaterial_Codigo
	WHERE m.Sillon_Codigo IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.MaterialPorSillon mps
		WHERE mps.MaterialPorSillon_Material = u2.Material_Codigo AND mps.MaterialPorSillon_Sillon = m.Sillon_Codigo
	);
END
GO
/*
------------------------------------------------------
                Migracion de Tela
------------------------------------------------------
*/
-- (14) Tela

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Tela
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Tela(Tela_Material, Tela_Color, Tela_Textura)
	SELECT DISTINCT u2.Material_Codigo, m.Tela_Color, m.Tela_Textura
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.TipoMaterial u1 ON u1.TipoMaterial_Tipo = m.Material_Tipo AND u1.TipoMaterial_Nombre = m.Material_Nombre AND u1.TipoMaterial_Descripcion = m.Material_Descripcion
	JOIN LOS_POLLOS_HERMANOS.Material u2 ON u2.Material_Tipo = u1.TipoMaterial_Codigo
	WHERE m.Tela_Color IS NOT NULL AND m.Tela_Textura IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Tela t
		WHERE t.Tela_Material = u2.Material_Codigo AND t.Tela_Color = m.Tela_Color AND t.Tela_Textura = m.Tela_Textura
	);
END
GO
/*
------------------------------------------------------
                Migracion de Madera
------------------------------------------------------
*/
-- (15) Madera

CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Madera
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Madera(Madera_Material, Madera_Color, Madera_Dureza)
	SELECT DISTINCT u2.Material_Codigo, m.Madera_Color, m.Madera_Dureza
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.TipoMaterial u1 ON u1.TipoMaterial_Tipo = m.Material_Tipo AND u1.TipoMaterial_Nombre = m.Material_Nombre AND u1.TipoMaterial_Descripcion = m.Material_Descripcion
	JOIN LOS_POLLOS_HERMANOS.Material u2 ON u2.Material_Tipo = u1.TipoMaterial_Codigo
	WHERE m.madera_color IS NOT NULL AND m.Madera_Dureza IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Madera t
		WHERE t.Madera_Material = u2.Material_Codigo AND t.Madera_Color = m.Madera_Color AND t.Madera_Dureza = m.Madera_Dureza
	);
END
GO

/*
------------------------------------------------------
                Migracion de Relleno
------------------------------------------------------
*/
-- (16) Relleno
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Relleno
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.Relleno(Relleno_Material, Relleno_Densidad)
	SELECT DISTINCT u2.Material_Codigo, m.Relleno_Densidad
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.TipoMaterial u1 ON u1.TipoMaterial_Tipo = m.Material_Tipo AND u1.TipoMaterial_Nombre = m.Material_Nombre AND u1.TipoMaterial_Descripcion = m.Material_Descripcion
	JOIN LOS_POLLOS_HERMANOS.Material u2 ON u2.Material_Tipo = u1.TipoMaterial_Codigo
	WHERE m.Relleno_Densidad IS NOT NULL
	AND NOT EXISTS (
		SELECT * FROM LOS_POLLOS_HERMANOS.Relleno r
		WHERE r.Relleno_Material = u2.Material_Codigo AND r.Relleno_Densidad = m.Relleno_Densidad
	);
END
GO

/*
------------------------------------------------------
                Migracion de DetalleCompra
------------------------------------------------------
*/
-- (17) DetalleCompra
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_DetalleCompra
AS
BEGIN
	INSERT INTO LOS_POLLOS_HERMANOS.DetalleCompra(Detalle_Compra_Compra, Detalle_Compra_Material, Detalle_Compra_Cantidad, Detalle_Compra_Precio, Detalle_Compra_Subtotal)
	SELECT DISTINCT m.Compra_Numero, u2.Material_Codigo, m.Detalle_Compra_Cantidad, m.Detalle_Compra_Precio, m.Detalle_Compra_Subtotal
	FROM gd_esquema.Maestra m
	JOIN LOS_POLLOS_HERMANOS.TipoMaterial u1 ON u1.TipoMaterial_Tipo = m.Material_Tipo AND u1.TipoMaterial_Nombre = m.Material_Nombre AND u1.TipoMaterial_Descripcion = m.Material_Descripcion
	JOIN LOS_POLLOS_HERMANOS.Material u2 ON u2.Material_Tipo = u1.TipoMaterial_Codigo
	WHERE m.Compra_Numero IS NOT NULL
	AND NOT EXISTS (SELECT * FROM LOS_POLLOS_HERMANOS.DetalleCompra dc WHERE dc.Detalle_Compra_Compra = m.Compra_Numero);
END
GO

/*
------------------------------------------------------
		Ejecución de las Stored Procedures
------------------------------------------------------
*/
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Datos
AS
BEGIN
-- (5) Ubicacion 
EXEC LOS_POLLOS_HERMANOS.Migrar_Ubicacion;
-- (1) Cliente
EXEC LOS_POLLOS_HERMANOS.Migrar_Cliente;
-- (3) Sucursal
EXEC LOS_POLLOS_HERMANOS.Migrar_Sucursal;
-- (4) Proveedor
EXEC LOS_POLLOS_HERMANOS.Migrar_Proveedor;
-- (11) Medida
EXEC LOS_POLLOS_HERMANOS.Migrar_Medida;
-- (12) Modelo
EXEC LOS_POLLOS_HERMANOS.Migrar_Modelo;
-- (8) Sillon
EXEC LOS_POLLOS_HERMANOS.Migrar_Sillon;
-- (6) Compra
EXEC LOS_POLLOS_HERMANOS.Migrar_Compra;
-- (2) Factura
EXEC LOS_POLLOS_HERMANOS.Migrar_Factura;
-- (9) Pedido
EXEC LOS_POLLOS_HERMANOS.Migrar_Pedido;
-- (7) DetallePedido
EXEC LOS_POLLOS_HERMANOS.Migrar_DetallePedido;
-- (18) PedidoCancelacion
EXEC LOS_POLLOS_HERMANOS.Migrar_PedidoCancelacion;
-- (19) Envio
EXEC LOS_POLLOS_HERMANOS.Migrar_Envio;
-- (20) DetalleFactura
EXEC LOS_POLLOS_HERMANOS.Migrar_DetalleFactura;
-- (13) TipoMaterial
EXEC LOS_POLLOS_HERMANOS.Migrar_TipoMaterial;
-- (10) Material
EXEC LOS_POLLOS_HERMANOS.Migrar_Material;
-- (21) MaterialPorSillon
EXEC LOS_POLLOS_HERMANOS.Migrar_MaterialPorSillon;
-- (14) Tela
EXEC LOS_POLLOS_HERMANOS.Migrar_Tela;
-- (15) Madera
EXEC LOS_POLLOS_HERMANOS.Migrar_Madera;
-- (16) Relleno
EXEC LOS_POLLOS_HERMANOS.Migrar_Relleno;
-- (17) DetalleCompra
EXEC LOS_POLLOS_HERMANOS.Migrar_DetalleCompra;
END
GO

EXEC LOS_POLLOS_HERMANOS.Migrar_Datos;
GO