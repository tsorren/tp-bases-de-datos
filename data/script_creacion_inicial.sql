USE GD1C2025
GO
CREATE SCHEMA LOS_POLLOS_HERMANOS;
GO

-- (1) Stored Procedure para crear la tabla Ubicacion
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Ubicacion AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Ubicacion (
        Ubicacion_Codigo BIGINT IDENTITY (1,1) NOT NULL,
        Ubicacion_Provincia NVARCHAR(255),
        Ubicacion_Localidad NVARCHAR(255),
        Ubicacion_Direccion NVARCHAR(255)
    );
END
GO
-- Guardamos provincia, localidad y dirección para normalizar y evitar redundancias de datos geográficos
-- Utilizada por Cliente, Proveedor y Sucursal


-- (2) Stored Procedure para crear la tabla Cliente
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Cliente AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Cliente (
        Cliente_Codigo BIGINT IDENTITY (1,1) NOT NULL,
        Cliente_Ubicacion BIGINT,
        Cliente_Dni BIGINT,
        Cliente_Nombre NVARCHAR(255),
        Cliente_Apellido NVARCHAR(255),
        Cliente_Fecha_Nacimiento DATETIME2(6),
        Cliente_Mail NVARCHAR(255),
        Cliente_Telefono NVARCHAR(255)
    );
END
GO
-- Cada cliente tiene una Ubicacion y datos propios para pedidos, facturación y envíos


-- (3) Stored Procedure para crear la tabla Sucursal
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Sucursal AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Sucursal (
        Sucursal_Codigo BIGINT NOT NULL, 
        Sucursal_Ubicacion BIGINT,
        Sucursal_Telefono NVARCHAR(255),
        Sucursal_Mail NVARCHAR(255)
    );
END
GO
-- Cada factura, pedido y compra se asocia a una sucursal
-- Creando esta entidad evitamos redundacias dentro de las demás entidades


-- (4) Stored Procedure para crear la tabla Proveedor
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Proveedor AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Proveedor (
        Proveedor_Codigo BIGINT IDENTITY(1,1) NOT NULL,
		Proveedor_Ubicacion BIGINT,
        Proveedor_Cuit NVARCHAR(255),
        Proveedor_RazonSocial NVARCHAR(255),
        Proveedor_Telefono NVARCHAR(255),
        Proveedor_Mail NVARCHAR(255)
    );
END
GO
-- Representa a los proveedores de materiales (tela, madera, relleno)
-- A pesar de que Proveedor_Cuit no se repita decidimos crear Proveedor_Codigo
-- Esto nos permite manejar internamente los proveedores, asegurando su buen uso


-- (5) Stored Procedure para crear la tabla Factura
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Factura AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Factura (
        Factura_Numero BIGINT IDENTITY(46118858,1) NOT NULL, -- HARDCODE: Inicializamos Identity en MIN(Factura_Numero)
        Factura_Cliente BIGINT,
        Factura_Sucursal BIGINT,
        Factura_Fecha DATETIME2(6),
        Factura_Total DECIMAL(38,2)
    );
END
GO
-- Representa la factura que se registra cuando un pedido está completado y el cliente realiza el pago


-- (6) Stored Procedure para crear la tabla Compra
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Compra AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Compra (
        Compra_Numero DECIMAL(18,0) IDENTITY(12242153,1) NOT NULL, -- HARDCODE: Inicializamos Identity en MIN(Compra_Numero)
        Compra_Sucursal BIGINT,
        Compra_Proveedor BIGINT,
        Compra_Fecha DATETIME2(6),
        Compra_Total DECIMAL(18,2)
    );
END
GO
-- Corresponde a cada compra realizada a los proveedores desde las sucursales
-- Tiene uno o muchos DetalleCompra obligatoriamente


-- (7) Stored Procedure para crear la tabla Pedido
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Pedido AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Pedido (
        Pedido_Numero DECIMAL(18,0) IDENTITY(56360503,1) NOT NULL, -- HARDCODE: Inicializamos Identity en MIN(Pedido_Numero)
        Pedido_Cliente BIGINT,
        Pedido_Sucursal BIGINT,
        Pedido_Fecha DATETIME2(6),
        Pedido_Total DECIMAL(18,2),    
        Pedido_Estado NVARCHAR(255)
    );
END
GO
-- Corresponde a cada pedido que realiza un cliente
-- Puede tener un PedidoCancelacion y tiene uno o muchos DetallePedido (uno por sillón)


-- (8) Stored Procedure para crear la tabla Medida
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Medida AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Medida (
        Medida_Codigo BIGINT IDENTITY(1,1) NOT NULL,
        Medida_Ancho DECIMAL(18,2),
        Medida_Alto DECIMAL(18,2),
        Medida_Profundidad DECIMAL(18,2),
        Medida_Precio DECIMAL(18,2)
    );
END
GO
-- Guarda las dimensiones (alto, ancho, profundidad) elegidas por el cliente y su precio
-- Se puede aplicar a cualquier modelo de sillón, permitiendo combinaciones sin duplicar datos


-- (9) Stored Procedure para crear la tabla Modelo
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Modelo AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Modelo (
        Modelo_Codigo BIGINT NOT NULL,
        Modelo_Codigo_Numero NVARCHAR(255),
        Modelo_Descripcion NVARCHAR(255),
        Modelo_Precio_Base DECIMAL(18,2)
    );
END
GO
-- Esta entidad representa a cada modelo de sillón. Cada uno de los modelos tiene un precio base
-- El atributo Modelo_Codigo_Numero en el modelo que diseñamos se corresponde con el atributo Sillon_Modelo de la tabla maestra


-- (10) Stored Procedure para crear la tabla Sillon
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Sillon AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Sillon (
        Sillon_Codigo BIGINT NOT NULL,
        Sillon_Medida BIGINT,
        Sillon_Modelo BIGINT 
    );
END
GO
-- Esta entidad representa a cada sillón
-- El cliente es quien elige las medidas, modelo, y materiales que tendrá el mismo
-- Creamos una entidad intermedia MaterialPorSillon para modelar la relacion de muchos a muchos entre las entidades Sillon y Material


-- (11) Stored Procedure para crear la tabla DetallePedido
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_DetallePedido AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.DetallePedido (
        Detalle_Pedido_Numero BIGINT IDENTITY(1,1) NOT NULL,
		Detalle_Pedido_Sillon BIGINT,
        Detalle_Pedido_Pedido DECIMAL(18,0),
        Detalle_Pedido_Cantidad BIGINT,
        Detalle_Pedido_Precio DECIMAL(18,2),
        Detalle_Pedido_Subtotal DECIMAL(18,2)
    );
END
GO
-- Cada pedido puede tener varios sillones distintos, por lo que por cada sillón distinto a fabricar 
-- se registra la información contenida en esta entidad


-- (12) Stored Procedure para crear la tabla TipoMaterial
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_TipoMaterial AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.TipoMaterial (
        TipoMaterial_Codigo BIGINT IDENTITY(1,1) NOT NULL,
        TipoMaterial_Tipo NVARCHAR(255),
        TipoMaterial_Nombre NVARCHAR(255),
        TipoMaterial_Descripcion NVARCHAR(255)
    );
END
GO
-- Esta entidad se relaciona con Material, representa las características del mismo
-- El atributo de esta entidad llamado TipoMaterial_Tipo se corresponde con el atributo Material_Tipo de la tabla maestra


-- (13) Stored Procedure para crear la tabla Material
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Material AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Material (
        Material_Codigo BIGINT IDENTITY(1,1) NOT NULL,
        Material_Tipo BIGINT,
        Material_Precio DECIMAL(38,2)
    );
END
GO
-- Esta entidad representa a cada material que puede elegir el cliente para su sillón
-- Entre los materiales se encuentran distintos tipos de telas, maderas y rellenos
-- Cada uno de los materiales tiene un precio y características
-- Usa la entidad intermedia MaterialPorSillon para relacionarse correctamente con Sillon


-- (14) Stored Procedure para crear la tabla Tela
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Tela AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Tela (
        Tela_Codigo BIGINT IDENTITY(1,1) NOT NULL,
        Tela_Material BIGINT,
        Tela_Color NVARCHAR(255),
        Tela_Textura NVARCHAR(255)
    );
END
GO
-- Esta entidad representa a cada una de las telas con la que se fabrican los sillones
-- Contiene el color y la textura de las mismas


-- (15) Stored Procedure para crear la tabla Madera
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Madera AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Madera (
        Madera_Codigo BIGINT IDENTITY(1,1) NOT NULL,
        Madera_Material BIGINT,
        Madera_Color NVARCHAR(255),
        Madera_Dureza NVARCHAR(255)
    );
END
GO
-- Esta entidad representa a cada una de las maderas con la que se fabrican los sillones
-- Contiene el color y la dureza de las mismas


-- (16) Stored Procedure para crear la tabla Relleno
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Relleno AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Relleno (
        Relleno_Codigo BIGINT IDENTITY(1,1) NOT NULL,
        Relleno_Material BIGINT,
        Relleno_Densidad DECIMAL(38,2)
    );
END
GO
-- Esta entidad representa a cada una de los rellenos con los que se fabrican los sillones
-- Contiene información sobre la densidad de los mismos


-- (17) Stored Procedure para crear la tabla DetalleCompra
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_DetalleCompra AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.DetalleCompra (
        Detalle_Compra_Numero BIGINT IDENTITY(1,1) NOT NULL,
        Detalle_Compra_Compra DECIMAL(18,0),
        Detalle_Compra_Material BIGINT,
        Detalle_Compra_Cantidad DECIMAL(18,0),
        Detalle_Compra_Precio DECIMAL(18,2),
        Detalle_Compra_Subtotal DECIMAL(18,2)
    );
END
GO
-- Esta entidad representa el detalle de compra de cada material que se compra al proveedor
-- Es una entidad intermedia entre las entidades Compra y Material
-- Permite representar la relación de muchos a muchos entre ellas


-- (18) Stored Procedure para crear la tabla PedidoCancelacion
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_PedidoCancelacion AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion (
        Pedido_Cancelacion_Numero BIGINT IDENTITY(1,1) NOT NULL,
        Pedido_Cancelacion_Pedido DECIMAL(18,0),
        Pedido_Cancelacion_Fecha DATETIME2(6),
        Pedido_Cancelacion_Motivo VARCHAR(255)
    );
END
GO
-- Esta entidad representa la información de cada pedido cancelado
-- Debido a esto es obligatorio que se relacione con un Pedido existente


-- (19) Stored Procedure para crear la tabla Envio
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_Envio AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.Envio (
        Envio_Numero DECIMAL(18,0) IDENTITY(90664928,1) NOT NULL, -- HARDCODE: Inicializamos Identity en MIN(Envio_Numero)
        Envio_Factura BIGINT,
        Envio_Fecha_Programada DATETIME2(6),
        Envio_Fecha_Entrega DATETIME2(6),
        Envio_Importe_Traslado DECIMAL(18,2),
        Envio_Importe_Subida DECIMAL(18,2),
		Envio_Total DECIMAL(18,2)
    );
END
GO
-- Esta entidad contiene la información de envío relacionada a cada venta
-- Debe relacionarse con una Factura existente obligatoriamente


-- (20) Stored Procedure para crear la tabla DetalleFactura
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_DetalleFactura AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.DetalleFactura (
        Detalle_Factura_Numero BIGINT IDENTITY(1,1) NOT NULL,
        Detalle_Factura_Factura BIGINT,
        Detalle_Factura_Detalle_Pedido BIGINT,
        Detalle_Factura_Cantidad DECIMAL(18,0),
        Detalle_Factura_Precio DECIMAL(18,2),
        Detalle_Factura_Subtotal DECIMAL(18,2)
    );
END
GO
-- Esta entidad representa al detalle de la factura, conteniendo información sobre los ítems de la factura
-- Se relaciona tanto con la Factura como con el DetallePedido al que están asociados a los ítems facturados


-- (21) Stored Procedure para crear la tabla MaterialPorSillon
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTabla_MaterialPorSillon AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon (
        MaterialPorSillon_Codigo BIGINT IDENTITY(1,1) NOT NULL,
        MaterialPorSillon_Material BIGINT,
        MaterialPorSillon_Sillon BIGINT 
    );
END
GO
-- Esta entidad intermedia permite modelar correctamente la relacion entre las entidades Sillon y Material
-- ya que esta se trata de una relación de muchos a muchos


-- Stored procedure que ejecuta los stored procedures para crear todas las tablas
CREATE PROCEDURE LOS_POLLOS_HERMANOS.CrearTablas AS
BEGIN
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Ubicacion;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Cliente;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Sucursal;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Proveedor;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Factura;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Compra;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Pedido;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Medida;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Modelo;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Sillon;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_DetallePedido;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_TipoMaterial;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Material;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Tela;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Madera;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Relleno;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_DetalleCompra;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_PedidoCancelacion;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_Envio;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_DetalleFactura;
    EXEC LOS_POLLOS_HERMANOS.CrearTabla_MaterialPorSillon;
END
GO


-- Ejecución del stored procedure que crea todas las tablas
EXEC LOS_POLLOS_HERMANOS.CrearTablas;
GO


/*
----------------------------------------------
            Constraints primary key
----------------------------------------------
*/
-- (1) Ubicacion
ALTER TABLE LOS_POLLOS_HERMANOS.Ubicacion
ADD CONSTRAINT PK_Ubicacion 
    PRIMARY KEY (Ubicacion_Codigo)


-- (2) Cliente
ALTER TABLE LOS_POLLOS_HERMANOS.Cliente
ADD CONSTRAINT PK_Cliente 
    PRIMARY KEY (Cliente_Codigo);


-- (3) Sucursal
ALTER TABLE LOS_POLLOS_HERMANOS.Sucursal
ADD CONSTRAINT PK_Sucursal 
    PRIMARY KEY (Sucursal_Codigo);


-- (4) Proveedor
ALTER TABLE LOS_POLLOS_HERMANOS.Proveedor
ADD CONSTRAINT PK_Proveedor 
    PRIMARY KEY (Proveedor_Codigo);


-- (5) Factura
ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT PK_Factura 
    PRIMARY KEY (Factura_Numero);


-- (6) Compra
ALTER TABLE LOS_POLLOS_HERMANOS.Compra
ADD CONSTRAINT PK_Compra 
    PRIMARY KEY (Compra_Numero);


-- (7) Pedido
ALTER TABLE LOS_POLLOS_HERMANOS.Pedido
ADD CONSTRAINT PK_Pedido 
    PRIMARY KEY (Pedido_Numero);


-- (8) Medida
ALTER TABLE LOS_POLLOS_HERMANOS.Medida
ADD CONSTRAINT PK_Medida 
    PRIMARY KEY (Medida_Codigo);


-- (9) Modelo
ALTER TABLE LOS_POLLOS_HERMANOS.Modelo
ADD CONSTRAINT PK_Modelo 
    PRIMARY KEY (Modelo_Codigo);


-- (10) Sillon
ALTER TABLE LOS_POLLOS_HERMANOS.Sillon
ADD CONSTRAINT PK_Sillon 
    PRIMARY KEY (Sillon_Codigo);


-- (11) DetallePedido
ALTER TABLE LOS_POLLOS_HERMANOS.DetallePedido
ADD CONSTRAINT PK_DetallePedido 
    PRIMARY KEY (Detalle_Pedido_Numero);


-- (12) TipoMaterial
ALTER TABLE LOS_POLLOS_HERMANOS.TipoMaterial
ADD CONSTRAINT PK_TipoMaterial 
    PRIMARY KEY (TipoMaterial_Codigo);


-- (13) Material
ALTER TABLE LOS_POLLOS_HERMANOS.Material
ADD CONSTRAINT PK_Material 
    PRIMARY KEY (Material_Codigo);


-- (14) Tela
ALTER TABLE LOS_POLLOS_HERMANOS.Tela
ADD CONSTRAINT PK_Tela 
    PRIMARY KEY (Tela_Codigo);


-- (15) Madera
ALTER TABLE LOS_POLLOS_HERMANOS.Madera
ADD CONSTRAINT PK_Madera 
    PRIMARY KEY (Madera_Codigo);


-- (16) Relleno
ALTER TABLE LOS_POLLOS_HERMANOS.Relleno
ADD CONSTRAINT PK_Relleno 
    PRIMARY KEY (Relleno_Codigo);


-- (17) DetalleCompra
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT PK_DetalleCompra 
    PRIMARY KEY (Detalle_Compra_Numero);


-- (18) PedidoCancelacion
ALTER TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion
ADD CONSTRAINT PK_PedidoCancelacion 
    PRIMARY KEY (Pedido_Cancelacion_Numero);


-- (19) Envio
ALTER TABLE LOS_POLLOS_HERMANOS.Envio
ADD CONSTRAINT PK_Envio 
    PRIMARY KEY (Envio_Numero);


-- (20) DetalleFactura
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleFactura
ADD CONSTRAINT PK_DetalleFactura 
    PRIMARY KEY (Detalle_Factura_Numero);


-- (21) MaterialPorSillon
ALTER TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon
ADD CONSTRAINT PK_MaterialPorSillon 
    PRIMARY KEY (MaterialPorSillon_Codigo);


/*
----------------------------------------------
                Constraints foreign key
----------------------------------------------
*/

-- (1) Ubicacion
-- No tiene FK


-- (2) Cliente
ALTER TABLE LOS_POLLOS_HERMANOS.Cliente
ADD CONSTRAINT FK_Cliente_Ubicacion 
    FOREIGN KEY (Cliente_Ubicacion) 
    REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Codigo);
-- Relación con Ubicacion


-- (3) Sucursal
ALTER TABLE LOS_POLLOS_HERMANOS.Sucursal
ADD CONSTRAINT FK_Sucursal_Ubicacion 
    FOREIGN KEY (Sucursal_Ubicacion) 
    REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Codigo);
-- Relación con Ubicacion


-- (4) Proveedor
ALTER TABLE LOS_POLLOS_HERMANOS.Proveedor
ADD CONSTRAINT FK_Proveedor_Ubicacion 
    FOREIGN KEY (Proveedor_Ubicacion) 
    REFERENCES LOS_POLLOS_HERMANOS.Ubicacion(Ubicacion_Codigo);
-- Relación con Ubicacion


-- (5) Factura
ALTER TABLE LOS_POLLOS_HERMANOS.Factura
ADD CONSTRAINT FK_Factura_Cliente 
    FOREIGN KEY (Factura_Cliente) 
    REFERENCES LOS_POLLOS_HERMANOS.Cliente(Cliente_Codigo),
CONSTRAINT FK_Factura_SucursalFOREIGN 
    FOREIGN KEY (Factura_Sucursal) 
    REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo);
-- Relación con Cliente y Sucursal


-- (6) Compra
ALTER TABLE LOS_POLLOS_HERMANOS.Compra
ADD CONSTRAINT FK_Compra_Sucursal 
    FOREIGN KEY (Compra_Sucursal) 
    REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo),
CONSTRAINT FK_Compra_Proveedor 
    FOREIGN KEY (Compra_Proveedor) 
    REFERENCES LOS_POLLOS_HERMANOS.Proveedor(Proveedor_Codigo);
-- Relación con Sucursal y Proveedor


-- (7) Pedido
ALTER TABLE LOS_POLLOS_HERMANOS.Pedido
ADD CONSTRAINT FK_Pedido_Cliente 
    FOREIGN KEY (Pedido_Cliente) 
    REFERENCES LOS_POLLOS_HERMANOS.Cliente(Cliente_Codigo),
CONSTRAINT FK_Pedido_Sucursal 
    FOREIGN KEY (Pedido_Sucursal) 
    REFERENCES LOS_POLLOS_HERMANOS.Sucursal(Sucursal_Codigo);
-- Relación con Cliente y Sucursal

-- (8) Medida
-- No tiene FK


-- (9) Modelo
-- No tiene FK


-- (10) Sillon
ALTER TABLE LOS_POLLOS_HERMANOS.Sillon
ADD CONSTRAINT FK_Sillon_Medida 
    FOREIGN KEY (Sillon_Medida) 
    REFERENCES LOS_POLLOS_HERMANOS.Medida(Medida_Codigo),
CONSTRAINT FK_Sillon_Modelo 
    FOREIGN KEY (Sillon_Modelo) 
    REFERENCES LOS_POLLOS_HERMANOS.Modelo(Modelo_Codigo);
-- Relación con Medida y Modelo


-- (11) DetallePedido
ALTER TABLE LOS_POLLOS_HERMANOS.DetallePedido
ADD CONSTRAINT FK_DetallePedido_Sillon 
    FOREIGN KEY (Detalle_Pedido_Sillon) 
    REFERENCES LOS_POLLOS_HERMANOS.Sillon(Sillon_Codigo),
CONSTRAINT FK_DetallePedido_Pedido 
    FOREIGN KEY (Detalle_Pedido_Pedido) 
    REFERENCES LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero);
-- Relación con Sillon y Pedido

-- (12) TipoMaterial
-- No tiene FK


-- (13) Material
ALTER TABLE LOS_POLLOS_HERMANOS.Material
ADD CONSTRAINT FK_Material_TipoMaterial 
    FOREIGN KEY (Material_Tipo) 
    REFERENCES LOS_POLLOS_HERMANOS.TipoMaterial(TipoMaterial_Codigo);
-- Relación con TipoMaterial


-- (14) Tela
ALTER TABLE LOS_POLLOS_HERMANOS.Tela
ADD CONSTRAINT FK_Tela_Material 
    FOREIGN KEY (Tela_Material) 
    REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo);
-- Relación con Material


-- (15) Madera
ALTER TABLE LOS_POLLOS_HERMANOS.Madera
ADD CONSTRAINT FK_Madera_Material 
    FOREIGN KEY (Madera_Material) 
    REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo);
-- Relación con Material


-- (16) Relleno
ALTER TABLE LOS_POLLOS_HERMANOS.Relleno
ADD CONSTRAINT FK_Relleno_Material 
    FOREIGN KEY (Relleno_Material) 
    REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo);
-- Relación con Material


-- (17) DetalleCompra
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT FK_DetalleCompra_Compra 
    FOREIGN KEY (Detalle_Compra_Compra) 
    REFERENCES LOS_POLLOS_HERMANOS.Compra(Compra_Numero),
CONSTRAINT FK_DetalleCompra_Material 
    FOREIGN KEY (Detalle_Compra_Material) 
    REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo);
-- Relación con Compra y Material


-- (18) PedidoCancelacion
ALTER TABLE LOS_POLLOS_HERMANOS.PedidoCancelacion
ADD CONSTRAINT FK_PedidoCancelacion_Pedido 
    FOREIGN KEY (Pedido_Cancelacion_Pedido) 
    REFERENCES LOS_POLLOS_HERMANOS.Pedido(Pedido_Numero);
-- Relación con Pedido


-- (19) Envio
ALTER TABLE LOS_POLLOS_HERMANOS.Envio
ADD CONSTRAINT FK_Envio_Factura 
    FOREIGN KEY (Envio_Factura) 
    REFERENCES LOS_POLLOS_HERMANOS.Factura(Factura_Numero);
-- Relación con Factura


-- (20) DetalleFactura
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleFactura
ADD CONSTRAINT FK_DetalleFactura_Factura 
    FOREIGN KEY (Detalle_Factura_Factura) 
    REFERENCES LOS_POLLOS_HERMANOS.Factura(Factura_Numero),
CONSTRAINT FK_DetalleFactura_DetallePedido 
    FOREIGN KEY (Detalle_Factura_Detalle_Pedido) 
    REFERENCES LOS_POLLOS_HERMANOS.DetallePedido(Detalle_Pedido_Numero);
-- Relación con Factura y DetallePedido


-- (21) MaterialPorSillon
ALTER TABLE LOS_POLLOS_HERMANOS.MaterialPorSillon
ADD CONSTRAINT FK_MaterialPorSillon_Material 
    FOREIGN KEY (MaterialPorSillon_Material) 
    REFERENCES LOS_POLLOS_HERMANOS.Material(Material_Codigo),
CONSTRAINT FK_MaterialPorSillon_Sillon 
    FOREIGN KEY (MaterialPorSillon_Sillon) 
    REFERENCES LOS_POLLOS_HERMANOS.Sillon(Sillon_Codigo);
-- Relación con Material y Sillon


/*
----------------------------------------------
                Funciones
----------------------------------------------
*/
GO
CREATE FUNCTION LOS_POLLOS_HERMANOS.validarTipoDeMaterial(@tipo NVARCHAR(255))
RETURNS BIT
BEGIN
    DECLARE @tiposDeMateriales TABLE (material NVARCHAR(255))
    INSERT INTO @tiposDeMateriales VALUES ('Madera'), ('Tela'), ('Relleno')
    IF EXISTS(
        SELECT 1 FROM @tiposDeMateriales WHERE material = @tipo
    )
        RETURN 1;
    RETURN 0;
END
GO
-- Esta función verifica que el tipo pasado por parámetro sea uno de 'Madera', 'Tela' o 'Relleno'
-- Permite escalabilidad a futuro agregando otro tipo de material en VALUES

/*
----------------------------------------------
                Constraints check
----------------------------------------------
*/

-- (8) Medida
ALTER TABLE LOS_POLLOS_HERMANOS.Medida
ADD CONSTRAINT CHK_Medida_Valores 
CHECK (
        Medida_Ancho > 0
        AND Medida_Alto > 0
        AND Medida_Profundidad > 0
        AND Medida_Precio >= 0
    );
-- Validamos que las medidas físicas (alto, ancho, profundidad) sean estrictamente positivas
-- y que el precio asociado a la medida no sea negativo


-- (9) Modelo
ALTER TABLE LOS_POLLOS_HERMANOS.Modelo
ADD CONSTRAINT CHK_Modelo_PrecioBase 
    CHECK (Modelo_Precio_Base >= 0);
-- Nos aseguramos de que ningún modelo tenga un precio base negativo


-- (11) DetallePedido
ALTER TABLE LOS_POLLOS_HERMANOS.DetallePedido
ADD CONSTRAINT CHK_DetallePedido_Valores 
    CHECK (
        Detalle_Pedido_Cantidad > 0
        AND Detalle_Pedido_Precio >= 0 
        AND Detalle_Pedido_Subtotal >= 0
    );
-- Validamos la integridad de los valores de cada ítem de pedido: 
-- cantidad debe ser positiva, precio y subtotal no pueden ser negativos


-- (12) TipoMaterial
ALTER TABLE LOS_POLLOS_HERMANOS.TipoMaterial
ADD CONSTRAINT CHK_TipoMaterial_Tipo 
    CHECK (LOS_POLLOS_HERMANOS.validarTipoDeMaterial(TipoMaterial_Tipo) = 1);
-- Utilizamos la función validarTipoDeMaterial para asegurarnos de que los tipos de materiales estén restringidos a los permitidos:
-- 'Tela', 'Madera' y 'Relleno'


-- (17) DetalleCompra
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleCompra
ADD CONSTRAINT CHK_DetalleCompra_Valores 
    CHECK (
        Detalle_Compra_Cantidad > 0
        AND Detalle_Compra_Precio >= 0
        AND Detalle_Compra_Subtotal >= 0
    );
-- Nos aseguramos de que la cantidad de materiales comprados sea positiva y que el precio y subtotal no sean negativos


-- (20) DetalleFactura
ALTER TABLE LOS_POLLOS_HERMANOS.DetalleFactura
ADD CONSTRAINT CHK_DetalleFactura_Valores 
    CHECK (
        Detalle_Factura_Cantidad > 0 
        AND Detalle_Factura_Precio >= 0 
        AND Detalle_Factura_Subtotal >= 0
    );
-- Nos aseguramos de la integridad de los valores para cantidades, precios y subtotales facturados de la misma manera que con DetallePedido


/*
----------------------------------------------
                Índices
----------------------------------------------
*/

--(1) Ubicacion
CREATE INDEX Index_Ubicacion
ON LOS_POLLOS_HERMANOS.Ubicacion (
    Ubicacion_Provincia,
    Ubicacion_Localidad,
    Ubicacion_Direccion
);
-- Creamos un índice compuesto sobre Provincia, Localidad y Dirección para optimizar
-- búsquedas por ubicación completa, utilizadas en Cliente, Proveedor y Sucursal


-- (2) Cliente
CREATE INDEX Index_Cliente
ON LOS_POLLOS_HERMANOS.Cliente (
    Cliente_Dni,
    Cliente_Nombre,
    Cliente_Apellido
);
-- Índice sobre DNI, Nombre y Apellido para agilizar búsquedas de clientes tanto por documento como por nombre


-- (3) Sucursal
-- No necesita la creación de un índice porque realizamos las búsquedas por su clave primaria


-- (4) Proveedor
CREATE INDEX Index_Proveedor
ON LOS_POLLOS_HERMANOS.Proveedor (
    Proveedor_Cuit,
    Proveedor_RazonSocial
);
-- Índice sobre CUIT y Razón Social para facilitar búsquedas de proveedores


-- (5) Factura
-- No necesita la creación de un índice porque realizamos las búsquedas por su clave primaria


-- (6) Compra
-- No necesita la creación de un índice porque realizamos las búsquedas por su clave primaria


-- (7) Pedido
-- No necesita la creación de un índice porque realizamos las búsquedas por su clave primaria


-- (8) Medida
CREATE INDEX Index_Medida
ON LOS_POLLOS_HERMANOS.Medida (
    Medida_Ancho,
    Medida_Alto,
    Medida_Profundidad,
    Medida_Precio
);
-- Índice para búsquedas por dimensiones y precio


-- (9) Modelo
-- No necesita la creación de un índice porque realizamos las búsquedas por su clave primaria


-- (10) Sillon
-- No necesita la creación de un índice porque realizamos las búsquedas por su clave primaria


-- (11) DetallePedido
CREATE INDEX Index_DetallePedido
ON LOS_POLLOS_HERMANOS.DetallePedido (
    Detalle_Pedido_Sillon,
    Detalle_Pedido_Pedido
);
-- Índice para optimizar búsquedas de detalles por Sillón y Pedido, agilizando consultas frecuentes sobre el contenido de un pedido


-- (12) TipoMaterial
CREATE INDEX Index_TipoMaterial
ON LOS_POLLOS_HERMANOS.TipoMaterial (
    TipoMaterial_Tipo,
    TipoMaterial_Nombre,
    TipoMaterial_Descripcion
);
-- Índice para facilitar búsquedas por tipo de material válido ('Madera', 'Tela', 'Relleno')


-- (13) Material
CREATE INDEX Index_Material
ON LOS_POLLOS_HERMANOS.Material (Material_Tipo);
-- Índice para poder acceder rapidamente a un material, agilizando consultas de pedidos y compras


-- (14) Tela
CREATE INDEX Index_Tela
ON LOS_POLLOS_HERMANOS.Tela (Tela_Color, Tela_Textura);
-- Índice para agilizar búsquedas por color y textura de tela a la hora de personalizar un sillón


-- (15) Madera
CREATE INDEX Index_Madera
ON LOS_POLLOS_HERMANOS.Madera (
    Madera_Color,
    Madera_Dureza
);
-- Índice para agilizar búsquedas por color y dureza de madera a la hora de personalizar un sillón


-- (16) Relleno
CREATE INDEX Index_Relleno
ON LOS_POLLOS_HERMANOS.Relleno (Relleno_Densidad);
-- Índice para agilizar búsquedas por densidad del relleno a la hora de personalizar un sillón


-- (17) DetalleCompra
CREATE INDEX Index_DetalleCompra
ON LOS_POLLOS_HERMANOS.DetalleCompra (
    Detalle_Compra_Compra,
    Detalle_Compra_Material
);
-- Índice sobre número de compra y material para agilizar 
-- búsquedas del material de una compra específica o de las compras que incluyan cierto material


-- (18) PedidoCancelacion
CREATE INDEX Index_PedidoCancelacion
ON LOS_POLLOS_HERMANOS.PedidoCancelacion (
    Pedido_Cancelacion_Pedido,
    Pedido_Cancelacion_Fecha
);
-- Índice para buscar cancelaciones por pedido o por fecha de cancelación


-- (19) Envio
-- No necesita la creación de un índice porque realizamos las búsquedas por su clave primaria


-- (20) DetalleFactura
CREATE INDEX Index_DetalleFactura
ON LOS_POLLOS_HERMANOS.DetalleFactura (
    Detalle_Factura_Factura,
    Detalle_Factura_Detalle_Pedido
);
-- Índice para búsquedas por número de factura o por detalle de pedido


-- (21) MaterialPorSillon
CREATE INDEX Index_MaterialPorSillon
ON LOS_POLLOS_HERMANOS.MaterialPorSillon (
    MaterialPorSillon_Material,
    MaterialPorSillon_Sillon
);
-- Índice para consultar todos los materiales de un sillón, o todos los sillones
-- que contienen cierto material. Útil en el armado del producto.
GO

/*
----------------------------------------------
				Migraciones
----------------------------------------------
*/
-- En cada migración incluimos una cláusula WHERE NOT EXISTS, la cual nos asegura que sólo migremos los datos una vez
-- Lo que implica que si intentamos correr el script por segunda vez, y los datos ya fueron migrados previamente, entonces
-- no se migra nada, de este modo evitamos un posible error de ejecutar el script dos veces y migrar todo de manera duplicada

/*
----------------------------------------------
            Migración de Ubicacion
----------------------------------------------
*/


-- (1) Ubicacion
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Ubicacion
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Ubicacion (
        Ubicacion_Provincia,
        Ubicacion_Localidad,
        Ubicacion_Direccion
    )
    SELECT
        m.Sucursal_Provincia,
        m.Sucursal_Localidad,
        m.Sucursal_Direccion
    FROM gd_esquema.Maestra m
    WHERE m.Sucursal_Provincia IS NOT NULL
    AND NOT EXISTS (    -- no lo vuelve a insertar si se ejecuta de vuelta el exec procedure y ya está migrado
        SELECT * 
        FROM LOS_POLLOS_HERMANOS.Ubicacion u
        WHERE
            u.Ubicacion_Provincia = m.Sucursal_Provincia
            AND u.Ubicacion_Localidad = m.Sucursal_Localidad
            AND u.Ubicacion_Direccion = m.Sucursal_Direccion
    )
    GROUP BY 
        m.Sucursal_Provincia,
        m.Sucursal_Localidad,
        m.Sucursal_Direccion
    UNION
    SELECT
        m.Cliente_Provincia,
        m.Cliente_Localidad,
        m.Cliente_Direccion
    FROM gd_esquema.Maestra m
    WHERE m.Cliente_Provincia IS NOT NULL
    AND NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Ubicacion u
        WHERE
            u.Ubicacion_Provincia = m.Cliente_Provincia
            AND u.Ubicacion_Localidad = m.Cliente_Localidad
            AND u.Ubicacion_Direccion = m.Cliente_Direccion
    )
    GROUP BY
        m.Cliente_Provincia,
        m.Cliente_Localidad,
        m.Cliente_Direccion
    UNION
    SELECT
        m.Proveedor_Provincia,
        m.Proveedor_Localidad,
        m.Proveedor_Direccion
    FROM gd_esquema.Maestra m
    WHERE
        m.Proveedor_Provincia IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Ubicacion u
            WHERE 
                u.Ubicacion_Provincia = m.Proveedor_Provincia
                AND u.Ubicacion_Localidad = m.Proveedor_Localidad
                AND u.Ubicacion_Direccion = m.Proveedor_Direccion
        )
    GROUP BY
        m.Proveedor_Provincia,
        m.Proveedor_Localidad,
        m.Proveedor_Direccion;
END
GO
-- Migramos los datos de ubicación desde la tabla Maestra a la tabla Ubicacion
-- Extrayendo las combinaciones únicas de provincia, localidad y dirección de sucursales, clientes y proveedores
-- Excluimos los registros nulos para evitar cargar datos incompletos
-- Utilizamos NOT EXISTS junto con GROUP BY para evitar duplicados, incluso si se ejecuta el procedimiento múltiples veces
-- Combinamos en un único INSERT la carga de ubicaciones de sucursales, clientes y proveedores mediante el uso de UNION


/*
----------------------------------------------
                Migración de Cliente
----------------------------------------------
*/


-- (2) Cliente
GO
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Cliente
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Cliente (
        Cliente_Ubicacion,
        Cliente_Dni,
        Cliente_Nombre,
        Cliente_Apellido,
        Cliente_Fecha_Nacimiento,
        Cliente_Mail, Cliente_Telefono
    )
    SELECT
        u.Ubicacion_Codigo,
        m.Cliente_Dni,
        m.Cliente_Nombre,
        m.Cliente_Apellido,
        m.Cliente_FechaNacimiento,
        m.Cliente_Mail,
        m.Cliente_Telefono
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.Ubicacion u ON 
        u.Ubicacion_Provincia = m.Cliente_Provincia  
        AND u.Ubicacion_Localidad = m.Cliente_Localidad  
        AND u.Ubicacion_Direccion = m.Cliente_Direccion
    WHERE NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Cliente c
        WHERE c.Cliente_Dni = m.Cliente_Dni
    )
    GROUP BY 
        u.Ubicacion_Codigo,
        m.Cliente_Dni,
        m.Cliente_Nombre,
        m.Cliente_Apellido,
        m.Cliente_FechaNacimiento,
        m.Cliente_Mail,
        m.Cliente_Telefono;
END
GO
-- Migramos los datos de los clientes desde la tabla Maestra a la tabla Cliente
-- relacionando cada cliente con su ubicación correspondiente mediante un JOIN con la tabla Ubicacion
-- Excluimos los registros ya existentes utilizando NOT EXISTS para evitar duplicados basados en el DNI
-- Aplicamos GROUP BY para asegurar que no se inserten múltiples veces los mismos datos por cliente
-- Insertamos en la tabla Cliente únicamente aquellos registros con una ubicación válida previamente migrada


/*
----------------------------------------------
            Migración de Sucursal
----------------------------------------------
*/

-- (3) Sucursal
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Sucursal
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Sucursal (
        Sucursal_Codigo,
        Sucursal_Ubicacion,
        Sucursal_Telefono,
        Sucursal_Mail
    )
    SELECT
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
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Sucursal s
        WHERE s.Sucursal_Codigo = m.Sucursal_NroSucursal
    )
	GROUP BY 
        m.Sucursal_NroSucursal,
        u.Ubicacion_Codigo,
        m.Sucursal_Telefono,
        m.Sucursal_Mail
	ORDER BY m.Sucursal_NroSucursal;
END
GO
-- Migramos los datos de sucursal desde la tabla Maestra a la tabla Sucursal
-- asociando cada sucursal con su ubicación correspondiente mediante un JOIN con Ubicacion
-- evitamos duplicados comprobando con NOT EXISTS sobre el código de sucursal
-- usamos GROUP BY para consolidar registros idénticos y ORDER BY para mantener el orden por número de sucursal
-- insertamos el número original de sucursal junto con teléfono y mail obtenidos de la tabla Maestra


/*
----------------------------------------------
            Migración de Proveedor
----------------------------------------------
*/

-- (4) Proveedor
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Proveedor
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Proveedor (
        Proveedor_Ubicacion,
        Proveedor_Cuit,
        Proveedor_RazonSocial,
        Proveedor_Telefono,
        Proveedor_Mail
    )
    SELECT
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
    WHERE NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Proveedor p
        WHERE p.Proveedor_Cuit = m.Proveedor_Cuit
    )
    GROUP BY 
        u.Ubicacion_Codigo,
        m.Proveedor_Cuit,
        m.Proveedor_RazonSocial,
        m.Proveedor_Telefono,
        m.Proveedor_Mail;
END
GO
-- Migramos los datos de proveedor desde la tabla Maestra a la tabla Proveedor
-- asociando cada proveedor con su ubicación correspondiente mediante un JOIN con Ubicacion
-- evitamos duplicados comprobando con NOT EXISTS sobre el CUIT del proveedor
-- usamos GROUP BY para consolidar registros idénticos y asegurar inserción única
-- insertamos la razón social, teléfono y mail tal como aparecen en la tabla Maestra


/*
------------------------------------------------------
                Migración de Factura
------------------------------------------------------
*/

-- (5) Factura
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Factura
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Factura (
        Factura_Cliente,
        Factura_Sucursal,
        Factura_Fecha,
        Factura_Total
    )
    SELECT
        c.Cliente_Codigo,
        s.Sucursal_Codigo,
        m.Factura_Fecha,
        m.Factura_Total
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.Cliente c ON
        c.Cliente_Dni = m.Cliente_Dni
        AND c.Cliente_Apellido = m.Cliente_Apellido
        AND c.Cliente_Nombre = m.Cliente_Nombre
    JOIN LOS_POLLOS_HERMANOS.Sucursal s ON
        s.Sucursal_Codigo = m.Sucursal_NroSucursal
    WHERE 
        m.Factura_Numero IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Factura f
            WHERE f.Factura_Numero = m.Factura_Numero
        )
    GROUP BY 
        m.Factura_Numero,
        c.Cliente_Codigo,
        s.Sucursal_Codigo,
        m.Factura_Fecha,
        m.Factura_Total
	ORDER BY m.Factura_Numero;
END
GO
-- Migramos las facturas de la tabla Maestra a la tabla Factura
-- asociando cada factura con su cliente y su sucursal mediante JOIN con Cliente y Sucursal
-- excluimos filas sin número de factura para no insertar facturas incompletas
-- evitamos duplicados comprobando con NOT EXISTS sobre el número de factura
-- usamos GROUP BY para consolidar registros y ORDER BY para mantener el orden por número de factura


/*
------------------------------------------------------
                Migración de Compra
------------------------------------------------------
*/

-- (6) Compra
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Compra
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Compra (
        Compra_Sucursal,
        Compra_Proveedor,
        Compra_Fecha,
        Compra_Total
    )
    SELECT
        s.Sucursal_Codigo,
        p.Proveedor_Codigo,
        m.Compra_Fecha,
        m.Compra_Total
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.Sucursal s ON
        s.Sucursal_Codigo = m.Sucursal_NroSucursal
    JOIN LOS_POLLOS_HERMANOS.Proveedor p ON
        p.Proveedor_Cuit = m.Proveedor_Cuit
        AND p.Proveedor_RazonSocial = m.Proveedor_RazonSocial
    WHERE NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Compra c
        WHERE c.Compra_Numero = m.Compra_Numero
    )
    GROUP BY 
        m.Compra_Numero,
        s.Sucursal_Codigo,
        p.Proveedor_Codigo,
        m.Compra_Fecha,
        m.Compra_Total
	ORDER BY m.Compra_Numero;
END
GO
-- Migramos las compras de materiales de la tabla Maestra a la tabla Compra
-- asociando cada compra con su sucursal y su proveedor mediante JOIN con Sucursal y Proveedor
-- evitamos duplicados comprobando con NOT EXISTS sobre el número de compra
-- usamos GROUP BY para consolidar registros y ORDER BY para mantener el orden por número de compra


/*
------------------------------------------------------
                Migración de Pedido
------------------------------------------------------
*/

-- (7) Pedido
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Pedido
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Pedido (
        Pedido_Cliente,
        Pedido_Sucursal,
        Pedido_Fecha,
        Pedido_Total,
        Pedido_Estado
    )
    SELECT 
        c.Cliente_Codigo,
        s.Sucursal_Codigo,
        m.Pedido_Fecha,
        m.Pedido_Total,
        m.Pedido_Estado
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.Cliente c ON
        c.Cliente_Dni = m.Cliente_Dni
        AND c.Cliente_Nombre = m.Cliente_Nombre
        AND c.Cliente_Apellido = m.Cliente_Apellido
    JOIN LOS_POLLOS_HERMANOS.Sucursal s ON
        s.Sucursal_Codigo = m.Sucursal_NroSucursal
    WHERE 
        m.Pedido_Numero IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Pedido p
            WHERE p.Pedido_Numero = m.Pedido_Numero
        )
    GROUP BY 
        m.Pedido_Numero,
        c.Cliente_Codigo,
        s.Sucursal_Codigo,
        m.Pedido_Fecha,
        m.Pedido_Total,
        m.Pedido_Estado
	ORDER BY m.Pedido_Numero;
END
GO
-- Migramos los pedidos de la tabla Maestra a la tabla Pedido
-- asociando cada pedido con su cliente usando JOIN sobre DNI, nombre y apellido
-- y asociando cada pedido con su sucursal usando JOIN sobre el número de sucursal
-- excluimos filas sin número de pedido para no insertar pedidos incompletos
-- evitamos duplicados comprobando con NOT EXISTS sobre el número de pedido
-- usamos GROUP BY para consolidar registros y ORDER BY para mantener el orden por número de pedido

/*
------------------------------------------------------
                Migración de Medida    
------------------------------------------------------
*/

-- (8) Medida
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Medida
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Medida (
        Medida_Ancho,
        Medida_Alto,
        Medida_Profundidad,
        Medida_Precio
    )
    SELECT 
        m.Sillon_Medida_Ancho,
        m.Sillon_Medida_Alto,
        m.Sillon_Medida_Profundidad,
        m.Sillon_Medida_Precio
    FROM gd_esquema.maestra m
    WHERE 
        m.Sillon_Medida_Alto IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Medida med
            WHERE
                med.Medida_Ancho = m.Sillon_Medida_Ancho
                AND med.Medida_Alto = m.Sillon_Medida_Alto
                AND med.Medida_Profundidad = m.Sillon_Medida_Profundidad
                AND med.Medida_Precio = m.Sillon_Medida_Precio
        )
    GROUP BY
        m.Sillon_Medida_Ancho,
        m.Sillon_Medida_Alto,
        m.Sillon_Medida_Profundidad,
        m.Sillon_Medida_Precio;
END
GO
-- Migramos las medidas desde la tabla Maestra a la tabla Medida
-- extraemos ancho, alto, profundidad y precio de Sillon_Medida desde la tabla Maestra
-- excluimos registros sin altura para evitar cargar medidas incompletas
-- utilizamos NOT EXISTS junto con GROUP BY para evitar duplicados y asegurar inserción única de cada combinación de medida


/*
------------------------------------------------------
                Migración de Modelo
------------------------------------------------------
*/

-- (9) Modelo
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Modelo
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Modelo (
        Modelo_Codigo,
        Modelo_Codigo_Numero,
        Modelo_Descripcion,
        Modelo_Precio_Base
    )
    SELECT 
        m.Sillon_Modelo_Codigo,
        m.Sillon_Modelo,
        m.Sillon_Modelo_Descripcion,
        m.Sillon_Modelo_Precio
    FROM gd_esquema.Maestra m
    WHERE m.Sillon_Modelo_Codigo IS NOT NULL
    AND NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Modelo mo
        WHERE
            mo.Modelo_Codigo = m.Sillon_Modelo_Codigo
            AND mo.Modelo_Codigo_Numero = m.Sillon_Modelo
    )
    GROUP BY 
        m.Sillon_Modelo_Codigo,
        m.Sillon_Modelo,
        m.Sillon_Modelo_Descripcion,
        m.Sillon_Modelo_Precio
	ORDER BY m.Sillon_Modelo_Codigo;
END
GO
-- Migramos los modelos desde la tabla Maestra a la tabla Modelo
-- extraemos código de modelo, número de modelo, descripción y precio base de Sillon_Modelo
-- excluimos registros sin código de modelo para evitar cargar datos incompletos
-- usamos NOT EXISTS junto con GROUP BY para evitar duplicados y asegurar inserción única de cada modelo
-- mantenemos el orden de carga por código de modelo usando ORDER BY


/*
------------------------------------------------------
                Migración de Sillon
------------------------------------------------------
*/

-- (10) Sillon
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Sillon
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Sillon (
        Sillon_Codigo,
        Sillon_Medida,
        Sillon_Modelo
    )
    SELECT
        m.Sillon_Codigo,
        me.Medida_Codigo,
        mo.Modelo_Codigo
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.Medida me ON
        me.Medida_Alto = m.Sillon_Medida_Alto
        AND me.Medida_Ancho = m.Sillon_Medida_Ancho
        AND me.Medida_Profundidad = m.Sillon_Medida_Profundidad
        AND me.Medida_Precio = m.Sillon_Medida_Precio
    JOIN LOS_POLLOS_HERMANOS.Modelo mo ON
        mo.Modelo_Codigo = m.Sillon_Modelo_Codigo                     
    WHERE NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Sillon s
        WHERE s.Sillon_Codigo = m.Sillon_Codigo
    )
    GROUP BY
        m.Sillon_Codigo,
        me.Medida_Codigo,
        mo.modelo_codigo
	ORDER BY m.Sillon_Codigo;
END
GO
-- Migramos los sillones desde la tabla Maestra a la tabla Sillon
-- extraemos el código de sillón y asociamos la medida usando JOIN sobre alto, ancho, profundidad y precio de Medida
-- asociamos el modelo usando JOIN sobre el código de modelo en Modelo
-- evitamos duplicados comprobando con NOT EXISTS sobre el código de sillón
-- usamos GROUP BY para consolidar registros y ORDER BY para mantener el orden por código de sillón


/*
------------------------------------------------------
                Migración de DetallePedido
------------------------------------------------------
*/

-- (11) DetallePedido
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_DetallePedido
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.DetallePedido (
        Detalle_Pedido_Sillon,
        Detalle_Pedido_Pedido,
        Detalle_Pedido_Cantidad,
        Detalle_Pedido_Precio,
        Detalle_Pedido_Subtotal
    )
    SELECT
        m.Sillon_Codigo,
        m.Pedido_Numero,
        m.Detalle_Pedido_Cantidad,
        m.Detalle_Pedido_Precio,
        m.Detalle_Pedido_Subtotal
    FROM gd_esquema.Maestra m
    WHERE
        m.Sillon_Codigo IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.DetallePedido dp
            WHERE dp.Detalle_Pedido_Sillon = m.Sillon_Codigo
        )
    GROUP BY 
        m.Sillon_Codigo,
        m.Pedido_Numero,
        m.Detalle_Pedido_Cantidad,
        m.Detalle_Pedido_Precio,
        m.Detalle_Pedido_Subtotal;
END
GO
-- Migramos los detalles de pedido desde la tabla Maestra a la tabla DetallePedido
-- extraemos código de sillón, número de pedido, cantidad, precio y subtotal tal como aparecen en Maestra
-- excluimos registros sin código de sillón para evitar procesar registros irrelevantes
-- utilizamos NOT EXISTS sobre el código de sillón para evitar duplicados por sillón
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de TipoMaterial
------------------------------------------------------
*/

-- (12) TipoMaterial
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_TipoMaterial
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.TipoMaterial (
        TipoMaterial_Tipo,
        TipoMaterial_Nombre,
        TipoMaterial_Descripcion
    )
    SELECT
        m.Material_Tipo,
        m.Material_Nombre,
        m.Material_Descripcion
    FROM gd_esquema.Maestra m
    WHERE m.material_tipo IS NOT NULL
    AND NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.TipoMaterial tm
        WHERE
            tm.TipoMaterial_Tipo = m.Material_Tipo
            AND tm.TipoMaterial_Nombre = m.Material_Nombre
            AND tm.TipoMaterial_Descripcion = m.Material_Descripcion
    )
    GROUP BY
        m.Material_Tipo,
        m.Material_Nombre,
        m.Material_Descripcion;
END
GO
-- Migramos los tipos de material desde la tabla Maestra a la tabla TipoMaterial
-- extraemos tipo de material, nombre y descripción tal como aparecen en Maestra
-- excluimos registros sin tipo de material para evitar procesar registros incompletos
-- utilizamos NOT EXISTS con tipo, nombre y descripción para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de Material
------------------------------------------------------
*/

-- (13) Material
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Material
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Material (
        Material_Tipo,
        Material_Precio
    )
    SELECT
        t.TipoMaterial_Codigo, m.Material_Precio
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.TipoMaterial t ON
        t.TipoMaterial_Tipo = m.Material_Tipo
        AND t.TipoMaterial_Nombre = m.Material_Nombre
        AND t.TipoMaterial_Descripcion = m.Material_Descripcion
    WHERE NOT EXISTS (
        SELECT *
        FROM LOS_POLLOS_HERMANOS.Material mat
        WHERE
            mat.Material_Tipo = t.TipoMaterial_Codigo
            AND mat.Material_Precio = m.Material_Precio
    )
    GROUP BY
        t.TipoMaterial_Codigo,
        m.Material_Precio;
END
GO
-- Migramos los materiales desde la tabla Maestra a la tabla Material
-- asociando cada material con su tipo mediante JOIN con TipoMaterial usando tipo, nombre y descripción
-- extraemos el código de tipo de material y el precio tal como aparecen en Maestra
-- utilizamos NOT EXISTS con tipo de material y precio para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de Tela
------------------------------------------------------
*/

-- (14) Tela
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Tela
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Tela (
        Tela_Material,
        Tela_Color,Tela_Textura
    )
    SELECT
        ma.Material_Codigo,
        m.Tela_Color,
        m.Tela_Textura
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.TipoMaterial tm ON
        tm.TipoMaterial_Tipo = m.Material_Tipo
        AND tm.TipoMaterial_Nombre = m.Material_Nombre
        AND tm.TipoMaterial_Descripcion = m.Material_Descripcion
    JOIN LOS_POLLOS_HERMANOS.Material ma ON
        ma.Material_Tipo = tm.TipoMaterial_Codigo
    WHERE
        m.Tela_Color IS NOT NULL
        AND m.Tela_Textura IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Tela t
            WHERE
                t.Tela_Material = ma.Material_Codigo
                AND t.Tela_Color = m.Tela_Color
                AND t.Tela_Textura = m.Tela_Textura
    )
    GROUP BY 
        ma.Material_Codigo,
        m.Tela_Color,
        m.Tela_Textura;
END
GO
-- Migramos las telas desde la tabla Maestra a la tabla Tela
-- asociamos cada registro con su tipo de material usando JOIN con TipoMaterial sobre tipo, nombre y descripción
-- luego vinculamos con Material usando JOIN con Material sobre el código de tipo de material
-- extraemos el código de material, color y textura tal como aparecen en Maestra
-- excluimos registros con color o textura nulos para evitar cargar datos incompletos
-- utilizamos NOT EXISTS con material, color y textura para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de Madera
------------------------------------------------------
*/

-- (15) Madera
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Madera
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Madera (
        Madera_Material,
        Madera_Color,
        Madera_Dureza
    )
    SELECT
        ma.Material_Codigo,
        m.Madera_Color,
        m.Madera_Dureza
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.TipoMaterial tm ON
        tm.TipoMaterial_Tipo = m.Material_Tipo
        AND tm.TipoMaterial_Nombre = m.Material_Nombre
        AND tm.TipoMaterial_Descripcion = m.Material_Descripcion
    JOIN LOS_POLLOS_HERMANOS.Material ma ON
        ma.Material_Tipo = tm.TipoMaterial_Codigo
    WHERE
        m.madera_color IS NOT NULL
        AND m.Madera_Dureza IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Madera mad
            WHERE
                mad.Madera_Material = ma.Material_Codigo
                AND mad.Madera_Color = m.Madera_Color
                AND mad.Madera_Dureza = m.Madera_Dureza
    )
    GROUP BY
        ma.Material_Codigo,
        m.Madera_Color,
        m.Madera_Dureza;
END
GO
-- Migramos las maderas desde la tabla Maestra a la tabla Madera
-- asociamos cada registro con su tipo de material usando JOIN con TipoMaterial sobre tipo, nombre y descripción
-- luego vinculamos con Material usando JOIN con Material sobre el código de tipo de material
-- extraemos el código de material, color y dureza tal como aparecen en Maestra
-- excluimos registros con color o dureza nulos para evitar cargar datos incompletos
-- utilizamos NOT EXISTS con material, color y dureza para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de Relleno
------------------------------------------------------
*/

-- (16) Relleno
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Relleno
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Relleno (
        Relleno_Material,
        Relleno_Densidad
    )
    SELECT
        ma.Material_Codigo,
        m.Relleno_Densidad
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.TipoMaterial tm ON
        tm.TipoMaterial_Tipo = m.Material_Tipo
        AND tm.TipoMaterial_Nombre = m.Material_Nombre
        AND tm.TipoMaterial_Descripcion = m.Material_Descripcion
    JOIN LOS_POLLOS_HERMANOS.Material ma ON
        ma.Material_Tipo = tm.TipoMaterial_Codigo
    WHERE
        m.Relleno_Densidad IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Relleno r
            WHERE
                r.Relleno_Material = ma.Material_Codigo
                AND r.Relleno_Densidad = m.Relleno_Densidad
    )
    GROUP BY 
        ma.Material_Codigo,
        m.Relleno_Densidad;
END
GO
-- Migramos los rellenos desde la tabla Maestra a la tabla Relleno
-- asociamos cada registro con su tipo de material usando JOIN con TipoMaterial sobre tipo, nombre y descripción
-- luego vinculamos con Material usando JOIN con Material sobre el código de tipo de material
-- extraemos el código de material y la densidad tal como aparecen en Maestra
-- excluimos registros con densidad nula para evitar cargar datos incompletos
-- utilizamos NOT EXISTS con material y densidad para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de DetalleCompra
------------------------------------------------------
*/

-- (17) DetalleCompra
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_DetalleCompra
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.DetalleCompra (
        Detalle_Compra_Compra,
        Detalle_Compra_Material,
        Detalle_Compra_Cantidad,
        Detalle_Compra_Precio,
        Detalle_Compra_Subtotal
    )
    SELECT
        m.Compra_Numero,
        ma.Material_Codigo,
        m.Detalle_Compra_Cantidad,
        m.Detalle_Compra_Precio,
        m.Detalle_Compra_Subtotal
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.TipoMaterial t ON
        t.TipoMaterial_Tipo = m.Material_Tipo
        AND t.TipoMaterial_Nombre = m.Material_Nombre
        AND t.TipoMaterial_Descripcion = m.Material_Descripcion
    JOIN LOS_POLLOS_HERMANOS.Material ma ON
        ma.Material_Tipo = t.TipoMaterial_Codigo
    WHERE
        m.Compra_Numero IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.DetalleCompra dc
            WHERE dc.Detalle_Compra_Compra = m.Compra_Numero
        )
    GROUP BY
        m.Compra_Numero,
        ma.Material_Codigo,
        m.Detalle_Compra_Cantidad,
        m.Detalle_Compra_Precio,
        m.Detalle_Compra_Subtotal;
END
GO
-- Migramos los detalles de compra desde la tabla Maestra a la tabla DetalleCompra
-- asociamos cada detalle con su tipo de material usando JOIN con TipoMaterial sobre tipo, nombre y descripción
-- luego vinculamos con Material usando JOIN sobre el código de tipo de material
-- extraemos número de compra, código de material, cantidad, precio y subtotal tal como aparecen en Maestra
-- excluimos registros sin número de compra para evitar procesar registros irrelevantes
-- utilizamos NOT EXISTS sobre el número de compra para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de PedidoCancelacion
------------------------------------------------------
*/

-- (18) PedidoCancelacion
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_PedidoCancelacion
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.PedidoCancelacion (
        Pedido_Cancelacion_Pedido,
        Pedido_Cancelacion_Fecha,
        Pedido_Cancelacion_Motivo
    )
    SELECT
        m.Pedido_Numero,
        m.Pedido_Cancelacion_Fecha,
        m.Pedido_Cancelacion_Motivo
    FROM gd_esquema.Maestra m
    WHERE
        m.Pedido_Cancelacion_Fecha IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.PedidoCancelacion pc
            WHERE pc.Pedido_Cancelacion_Pedido = m.Pedido_Numero
        )
    GROUP BY
        m.Pedido_Numero,
        m.Pedido_Cancelacion_Fecha,
        m.Pedido_Cancelacion_Motivo;
END
GO
-- Migramos las cancelaciones de pedido desde la tabla Maestra a la tabla PedidoCancelacion
-- extraemos número de pedido, fecha de cancelación y motivo tal como aparecen en Maestra
-- excluimos registros sin fecha de cancelación para evitar procesar entradas incompletas
-- utilizamos NOT EXISTS sobre el número de pedido para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción


/*
------------------------------------------------------
                Migración de Envio
------------------------------------------------------
*/

-- (19) Envio
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Envio
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.Envio (
        Envio_Factura,
        Envio_Fecha_Programada,
        Envio_Fecha_Entrega,
        Envio_Importe_Traslado,
        Envio_Importe_Subida,
		Envio_Total
    )
    SELECT 
        m.Factura_Numero,
        m.Envio_Fecha_Programada,
        m.Envio_Fecha,
        m.Envio_ImporteTraslado,
        m.Envio_ImporteSubida,
		m.Envio_Total
    FROM gd_esquema.Maestra m
    WHERE
        m.Envio_Numero IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.Envio e
            WHERE e.Envio_Numero = m.Envio_Numero
        )
    GROUP BY
        m.Envio_Numero,
        m.Factura_Numero,
        m.Envio_Fecha_Programada, 
        m.Envio_Fecha, 
        m.Envio_ImporteTraslado, 
        m.Envio_ImporteSubida,
		m.Envio_Total
	ORDER BY m.Envio_Numero;
END
GO
-- Migramos los envíos desde la tabla Maestra a la tabla Envio
-- extraemos número de factura como referencia, fecha programada, fecha de entrega,
-- importe de traslado e importe de subida tal como aparecen en Maestra
-- excluimos registros sin número de envío para evitar procesar entradas irrelevantes
-- utilizamos NOT EXISTS sobre el número de envío para evitar duplicados
-- aplicamos GROUP BY para consolidar registros únicos antes de la inserción y ORDER BY para mantener el orden por número de envío


/*
------------------------------------------------------
                Migración de DetalleFactura
------------------------------------------------------
*/

-- (20) DetalleFactura
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_DetalleFactura
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.DetalleFactura (
        Detalle_Factura_Factura,
        Detalle_Factura_Detalle_Pedido,
        Detalle_Factura_Cantidad,
        Detalle_Factura_Precio,
        Detalle_Factura_Subtotal
    )
    SELECT
        m.Factura_Numero,
        dp.Detalle_Pedido_Numero,
        m.Detalle_Factura_Cantidad,
        m.Detalle_Factura_Precio,
        m.Detalle_Factura_Subtotal
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.Factura f ON
        m.Factura_Numero = f.Factura_Numero
    JOIN (
        SELECT
            MIN(Detalle_Pedido_Numero) AS Detalle_Pedido_Numero,
            Detalle_Pedido_Pedido,
            Detalle_Pedido_Cantidad,
            Detalle_Pedido_Precio,
            Detalle_Pedido_Subtotal
        FROM LOS_POLLOS_HERMANOS.DetallePedido 
        GROUP BY
            Detalle_Pedido_Pedido,
            Detalle_Pedido_Cantidad,
            Detalle_Pedido_Precio,
            Detalle_Pedido_Subtotal
    ) dp ON -- uso subselect dentro del join porque hay filas con valores repetidos
        dp.Detalle_Pedido_Pedido = m.Pedido_Numero
        AND dp.Detalle_Pedido_Cantidad = m.Detalle_Factura_Cantidad
        AND dp.Detalle_Pedido_Precio = m.Detalle_Factura_Precio
        AND dp.Detalle_Pedido_Subtotal = m.Detalle_Factura_Subtotal
        WHERE
            m.Detalle_Factura_Precio IS NOT NULL
            AND m.Detalle_Factura_Cantidad IS NOT NULL
            AND m.Detalle_Factura_Subtotal IS NOT NULL
            AND m.Pedido_Numero IS NOT NULL
            AND NOT EXISTS (
                SELECT *
                FROM LOS_POLLOS_HERMANOS.DetalleFactura df
                WHERE df.Detalle_Factura_Factura = m.Factura_Numero
            );
END
GO
-- Migramos los detalles de factura desde la tabla Maestra a la tabla DetalleFactura
-- extraemos número de factura y número de detalle de pedido junto con cantidad,
-- precio y subtotal tal como aparecen en Maestra
-- asociamos cada registro al detalle de pedido mediante JOIN con un subselect que agrupa por pedido,
-- cantidad, precio y subtotal, eligiendo el primer Detalle_Pedido_Numero para evitar filas repetidas
-- filtramos valores nulos de cantidad, precio, subtotal y número de pedido para evitar procesar datos incompletos
-- utilizamos NOT EXISTS sobre número de factura para evitar duplicados  


/*
------------------------------------------------------
                Migración de MaterialPorSillon
------------------------------------------------------
*/

-- (21) MaterialPorSillon
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_MaterialPorSillon
AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.MaterialPorSillon (
        MaterialPorSillon_Material,
        MaterialPorSillon_Sillon
    )
    SELECT ma.Material_Codigo, m.Sillon_Codigo
    FROM gd_esquema.Maestra m
    JOIN LOS_POLLOS_HERMANOS.TipoMaterial t ON
        t.TipoMaterial_Tipo = m.Material_Tipo
        AND t.TipoMaterial_Nombre = m.Material_Nombre
        AND t.TipoMaterial_Descripcion = m.Material_Descripcion
    JOIN LOS_POLLOS_HERMANOS.Material ma ON
        ma.Material_Tipo = t.TipoMaterial_Codigo
    WHERE
        m.Sillon_Codigo IS NOT NULL
        AND NOT EXISTS (
            SELECT *
            FROM LOS_POLLOS_HERMANOS.MaterialPorSillon mps
            WHERE
                mps.MaterialPorSillon_Material = ma.Material_Codigo
                AND mps.MaterialPorSillon_Sillon = m.Sillon_Codigo
        );
END
GO
-- Migramos la relación MaterialPorSillon desde la tabla Maestra a la tabla MaterialPorSillon
-- asociando cada material con su sillón usando JOIN con TipoMaterial sobre tipo, nombre y descripción y luego JOIN con Material sobre el código de tipo de material
-- extraemos el código de material y el código de sillón tal como aparecen en Maestra
-- excluimos registros sin código de sillón para evitar procesar relaciones inválidas
-- utilizamos NOT EXISTS sobre material y sillón para evitar duplicados  


/*
------------------------------------------------------
        Ejecución de la migración
------------------------------------------------------
*/


-- Stored procedure que engloba todas las migraciones
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Datos AS
BEGIN 
    EXEC LOS_POLLOS_HERMANOS.Migrar_Ubicacion; -- (20528 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Cliente; -- (20509 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Sucursal; -- (9 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Proveedor; -- (10 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Factura; -- (17408 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Compra; -- (79 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Pedido; -- (20509 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Medida; -- (4 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Modelo; -- (7 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Sillon; -- (72166 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_DetallePedido; -- (72166 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_TipoMaterial; -- (9 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Material; -- (9 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Tela; -- (3 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Madera; -- (3 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Relleno; -- (3 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_DetalleCompra; -- (711 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_PedidoCancelacion; -- (3101 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_Envio; -- (17408 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_DetalleFactura; -- (61092 rows affected)
    EXEC LOS_POLLOS_HERMANOS.Migrar_MaterialPorSillon; -- (216498 rows affected)
END
GO

-- Ejecución de Stored Procedure de migración de datos
EXEC LOS_POLLOS_HERMANOS.Migrar_Datos;
GO

/*
----------------------------------------------
                Triggers
----------------------------------------------
*/
-- Creamos los triggers después de la migración para que no interfieran durante la misma

-- (11) DetallePedido
CREATE TRIGGER LOS_POLLOS_HERMANOS.ActualizarTotalDePedido
ON LOS_POLLOS_HERMANOS.DetallePedido
AFTER INSERT, UPDATE, DELETE
AS
    UPDATE f
    SET f.Pedido_Total = (
		-- El total del pedido es la suma de los subtotales de los detalles de pedido asociados
        SELECT SUM(d.Detalle_Pedido_Subtotal)
        FROM LOS_POLLOS_HERMANOS.DetallePedido d
        WHERE d.Detalle_Pedido_Pedido = f.Pedido_Numero
    )
    FROM LOS_POLLOS_HERMANOS.Pedido f
    WHERE f.Pedido_Numero IN (
        SELECT DISTINCT Detalle_Pedido_Pedido FROM inserted
        UNION
        SELECT DISTINCT Detalle_Pedido_Pedido FROM deleted
    );
GO
-- Trigger que actualiza el total de cada pedido tras cambios en DetallePedido
-- se ejecuta luego de insertar, modificar o borrar sobre DetallePedido
-- recalcula el total del pedido como la suma de los subtotales de sus ítems
-- se aplica solo a los pedidos afectados, identificados mediante inserted y deleted


-- (17) DetalleCompra
CREATE TRIGGER LOS_POLLOS_HERMANOS.ActualizarTotalDeCompra
ON LOS_POLLOS_HERMANOS.DetalleCompra
AFTER INSERT, UPDATE, DELETE
AS
    UPDATE f
    SET f.Compra_Total = (
		-- El total de la compra es la suma de los subtotales de los detalles de compra asociados
        SELECT SUM(d.Detalle_Compra_Subtotal)
        FROM LOS_POLLOS_HERMANOS.DetalleCompra d
        WHERE d.Detalle_Compra_Compra = f.Compra_Numero
    )
    FROM LOS_POLLOS_HERMANOS.Compra f
    WHERE f.Compra_Numero IN (
        SELECT DISTINCT Detalle_Compra_Compra FROM inserted
        UNION
        SELECT DISTINCT Detalle_Compra_Compra FROM deleted
    );
GO
-- Trigger que actualiza el total de cada compra tras cambios en DetalleCompra
-- se ejecuta luego de insertar, modificar o borrar sobre DetalleCompra
-- recalcula el total de la compra como la suma de los subtotales de sus ítems
-- se aplica solo a las compras afectadas, identificadas mediante inserted y deleted


-- (19) Envio
CREATE TRIGGER LOS_POLLOS_HERMANOS.ActualizarTotalDeEnvio
ON LOS_POLLOS_HERMANOS.Envio
AFTER UPDATE
AS
	UPDATE e
	SET e.Envio_Total = (
		-- El total del envío es la suma del importe de traslado más el importe de subida del mismo
        SELECT e2.Envio_Importe_Traslado + e2.Envio_Importe_Subida
        FROM LOS_POLLOS_HERMANOS.Envio e2
        WHERE e2.Envio_Numero = e.Envio_Numero
    )
    FROM LOS_POLLOS_HERMANOS.Envio e
    WHERE e.Envio_Numero IN (
        SELECT DISTINCT Envio_Numero FROM inserted
        UNION
        SELECT DISTINCT Envio_Numero FROM deleted
    );
GO
-- Trigger que actualiza el total de cada envío tras cambios en Envio
-- se ejecuta luego de modificar sobre Envio
-- recalcula el total del envío como la suma del importe de traslado más el importe de subida
-- se aplica solo a los envíos afectados, identificados mediante inserted y deleted


-- (20) DetalleFactura
CREATE TRIGGER LOS_POLLOS_HERMANOS.ActualizarTotalDeFactura
ON LOS_POLLOS_HERMANOS.DetalleFactura
AFTER INSERT, UPDATE, DELETE
AS
    UPDATE f
    SET f.Factura_Total = (
        -- El total de la factura es la suma de los subtotales de los detalles de factura asociados, más el costo del envío
        SELECT SUM(d.Detalle_Factura_Subtotal) + ISNULL((e.Envio_Importe_Traslado + e.Envio_Importe_Subida),0)
        FROM LOS_POLLOS_HERMANOS.DetalleFactura d
        JOIN LOS_POLLOS_HERMANOS.Envio e ON e.Envio_Factura = f.Factura_Numero
        WHERE d.Detalle_Factura_Factura = f.Factura_Numero
        GROUP BY
            e.Envio_Importe_Traslado,
            e.Envio_Importe_Subida
    )
    FROM LOS_POLLOS_HERMANOS.Factura f
    WHERE f.Factura_Numero IN (
        SELECT DISTINCT Detalle_Factura_Factura FROM inserted
        UNION
        SELECT DISTINCT Detalle_Factura_Factura FROM deleted
    );
GO
-- Trigger que actualiza el total de cada factura tras cambios en DetalleFactura
-- se ejecuta luego de insertar, modificar o borrar sobre DetalleFactura
-- realiza un JOIN con Envio para sumar subtotales de detalle y costos de envío
-- agrupa por importes de traslado y subida para calcular el nuevo total de la factura
-- se aplica solo a las facturas afectadas, usando inserted y deleted para identificar los cambios