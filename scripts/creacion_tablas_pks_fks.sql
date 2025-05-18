use GD1C2025

-- (1) Cliente
CREATE TABLE LOS_POLLOS_HERMANOS.Cliente (
    Cliente_Id BIGINT NOT NULL,
    Cliente_Ubicacion BIGINT,
    Cliente_DNI BIGINT,
    Cliente_Nombre NVARCHAR(255),
    Cliente_Apellidos NVARCHAR(255),
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
    Sucursal_Numero BIGINT NOT NULL,
    Sucursal_Ubicacion BIGINT,
    Sucursal_Telefono NVARCHAR(255),
    Sucursal_Mail NVARCHAR(255)
);

-- (4) Proveedor
CREATE TABLE LOS_POLLOS_HERMANOS.Proveedor (
    Proveedor_Id BIGINT NOT NULL,
    Proveedor_Ubicacion BIGINT,
    Proveedor_Cuit NVARCHAR(255),
    Proveedor_RazonSocial NVARCHAR(255),
    Proveedor_Telefono NVARCHAR(255),
    Proveedor_Mail NVARCHAR(255)
);

-- (5) Ubicacion
CREATE TABLE LOS_POLLOS_HERMANOS.Ubicacion (
    Ubicacion_Id BIGINT NOT NULL,
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
    Detalle_Pedido_Numero BIGINT NOT NULL,
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
    Material_Codigo BIGINT NOT NULL,
    Material_Tipo BIGINT, 
    Material_Nombre NVARCHAR(255),
    Material_Descripcion NVARCHAR(255),
    Material_Precio DECIMAL(38,2)
);

-- (11) Medida
CREATE TABLE LOS_POLLOS_HERMANOS.Medida (
    Medida_Codigo BIGINT NOT NULL,
    Medida_Ancho DECIMAL(8,2),
    Medida_Alto DECIMAL(8,2),
    Medida_Profundidad DECIMAL(8,2),
    Medida_Precio DECIMAL(8,2)
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
    TipoMaterial_Codigo BIGINT NOT NULL,
    TipoMaterial_Tipo NVARCHAR(255)
);

-- (14) Tela
CREATE TABLE LOS_POLLOS_HERMANOS.Tela (
    Tela_Id BIGINT NOT NULL,
    Tela_Color NVARCHAR(255),
    Tela_Textura NVARCHAR(255)
);

-- (15) Madera
CREATE TABLE LOS_POLLOS_HERMANOS.Madera (
    Madera_Id BIGINT NOT NULL,
    Madera_Color NVARCHAR(255),
    Madera_Dureza NVARCHAR(255)
);

-- (16) Relleno
CREATE TABLE LOS_POLLOS_HERMANOS.Relleno (
    Relleno_Id BIGINT NOT NULL,
    Relleno_Dureza DECIMAL(38,2)
);

-- (17) DetalleCompra
CREATE TABLE LOS_POLLOS_HERMANOS.DetalleCompra (
    Detalle_Compra_Codigo BIGINT NOT NULL,
    Detalle_Compra_Compra DECIMAL(18,0),
    Detalle_Compra_Material BIGINT,
    Detalle_Compra_Cantidad DECIMAL(18,0),
    Detalle_Compra_Precio DECIMAL(18,2),
    Detalle_Compra_Subtotal DECIMAL(18,2)
);

-- (18) PedidoCancelacion
CREATE TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion (
    Pedido_Cancelacion_Numero BIGINT NOT NULL,
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
    Envio_Importe_Translado DECIMAL(18,2),
    Envio_Importe_Subida DECIMAL(18,2)
);

-- (20) DetalleFactura
CREATE TABLE LOS_POLLOS_HERMANOS.DetalleFactura (
    Detalle_Factura_Numero BIGINT NOT NULL,
    Detalle_Factura_Factura BIGINT,
    Detalle_Factura_Detalle_Pedido BIGINT,
    Detalle_Factura_Cantidad DECIMAL(18,0),
    Detalle_Factura_Precio DECIMAL(18,2),
    Detalle_Factura_Subtotal DECIMAL(18,2)
); 

-- (21) MaterialPorSillon
CREATE TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon (
    MaterialPorSillon_Codigo BIGINT NOT NULL,
    MaterialPorSillon_Material BIGINT,
    MaterialPorSillon_Sillon BIGINT 
);

-- Constraints Primary Key
-- (1) Cliente
ALTER TABLE LOS_POLLOS_HERMANOS.Cliente
ADD CONSTRAINT PK_Cliente PRIMARY KEY (Cliente_Id)

-- (2) Factura
ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT PK_Factura PRIMARY KEY (Factura_Numero)

-- (3) Sucursal
ALTER TABLE LOS_POLLOS_HERMANOS.Sucursal
ADD CONSTRAINT PK_Sucursal PRIMARY KEY (Sucursal_Numero)

-- (4) Proveedor
ALTER TABLE LOS_POLLOS_HERMANOS.Proveedor
ADD CONSTRAINT PK_Proveedor PRIMARY KEY (Proveedor_Id)

-- (5) Ubicacion
ALTER TABLE LOS_POLLOS_HERMANOS.Ubicacion
ADD CONSTRAINT PK_Ubicacion PRIMARY KEY (Ubicacion_Id)

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
ADD CONSTRAINT PK_Tela PRIMARY KEY (Tela_Id)

-- (15) Madera
ALTER TABLE LOS_POLLOS_HERMANOS.Madera
ADD CONSTRAINT PK_Madera PRIMARY KEY (Madera_Id)

-- (16) Relleno
ALTER TABLE LOS_POLLOS_HERMANOS.Relleno
ADD CONSTRAINT PK_Relleno PRIMARY KEY (Relleno_Id)

-- (17) DetalleCompra
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT PK_DetalleCompra PRIMARY KEY (Detalle_Compra_Codigo)

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

-- Constraints Foreign key
-- (1) Cliente
ALTER TABLE LOS_POLLOS_HERMANOS.Cliente
ADD CONSTRAINT FK_Cliente_Ubicacion FOREIGN KEY (Cliente_Ubicacion) REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Id)

-- (2) Factura
ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT FK_Factura_Cliente FOREIGN KEY (Factura_Cliente) REFERENCES LOS_POLLOS_HERMANOS.Cliente(Cliente_Id)

ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT FK_Factura_Sucursal FOREIGN KEY (Factura_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Numero)

-- (3) Sucursal
ALTER TABLE LOS_POLLOS_HERMANOS.Sucursal
ADD CONSTRAINT FK_Sucursal_Ubicacion FOREIGN KEY (Sucursal_Ubicacion) REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Id)

-- (4) Proveedor
ALTER TABLE LOS_POLLOS_HERMANOS.Proveedor
ADD CONSTRAINT FK_Proveedor_Ubicacion FOREIGN KEY (Proveedor_Ubicacion) REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Id)

-- (5) Ubicacion
-- No tiene FK

-- (6) Compra
ALTER TABLE LOS_POLLOS_HERMANOS.Compra
ADD CONSTRAINT FK_Compra_Sucursal FOREIGN KEY (Compra_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Numero)

ALTER TABLE LOS_POLLOS_HERMANOS.Compra
ADD CONSTRAINT FK_Compra_Proveedor FOREIGN KEY (Compra_Proveedor) REFERENCES LOS_POLLOS_HERMANOS.Proveedor(Proveedor_Id)

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
ADD CONSTRAINT FK_Pedido_Sucursal FOREIGN KEY (Pedido_Sucursal) REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Numero)

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
ADD CONSTRAINT FK_Tela_TipoMaterial FOREIGN KEY (Tela_Id) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

-- (15) Madera
ALTER TABLE LOS_POLLOS_HERMANOS.Madera
ADD CONSTRAINT FK_Madera_TipoMaterial FOREIGN KEY (Madera_Id) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

-- (16) Relleno
ALTER TABLE LOS_POLLOS_HERMANOS.Relleno
ADD CONSTRAINT FK_Relleno_TipoMaterial FOREIGN KEY (Relleno_Id) REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo)

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
