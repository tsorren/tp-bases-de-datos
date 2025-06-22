USE GD1C2025
GO

-- ==================
-- RESET DE MODELO BI
-- ==================

-- Hechos
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Envios', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Compras', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Compras;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Ventas', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Ventas;
-- Dimensiones 
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Cliente', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Cliente;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo', 'U') IS NOT NULL 
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo;


-- ===================================
-- CREACIÓN DE TABLAS BI - DIMENSIONES
-- ===================================

-- (1) Dimensión Tiempo
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo (
    Tiempo_Id BIGINT IDENTITY(1,1) NOT NULL,
    Tiempo_Anio SMALLINT,
    Tiempo_Cuatrimestre TINYINT,
    Tiempo_Mes TINYINT
);

-- (2) Dimensión Cliente
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Cliente (
    Cliente_Id BIGINT NOT NULL,
    Cliente_Rango_Etario VARCHAR(10)
);

-- (3) Dimensión Ubicacion
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion (
    Ubicacion_Id BIGINT IDENTITY(1,1) NOT NULL, -- Usamos identity porque se repite por direccion en el modelo oltp
    Ubicacion_Provincia NVARCHAR(255),
    Ubicacion_Localidad NVARCHAR(255)
);

-- (4) Dimensión Sucursal
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal (
    Sucursal_Id BIGINT NOT NULL
);

-- (5) Dimensión Modelo_Sillon
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon (
    Modelo_Sillon_Id BIGINT NOT NULL,
    Modelo_Sillon_Descripcion NVARCHAR(255),
    Modelo_Sillon_Precio_Base DECIMAL(18,2)
);

-- (6) Dimensión Tipo_Material
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material (
    Tipo_Material_Id BIGINT NOT NULL,
    Tipo_Material_Tipo NVARCHAR(255),
    Tipo_Material_Precio DECIMAL(38,2)
);

-- (7) Dimensión Estado_Pedido
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido (
    Estado_Pedido_Id BIGINT IDENTITY(1,1) NOT NULL,
    Estado_Pedido_Estado NVARCHAR(255),
);

-- (8) Dimensión Turno_Venta
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta (
    Turno_Venta_Id BIGINT IDENTITY(1,1) NOT NULL,
    Turno_Venta_Horario VARCHAR(20)
);

-- ==============================
-- CREACIÓN DE TABLAS BI - HECHOS
-- ==============================

-- (1) Hechos Ventas
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Ventas (
    Tiempo_Id BIGINT NOT NULL,
    Sucursal_Id BIGINT NOT NULL,
    Ubicacion_Id BIGINT NOT NULL,
    Cliente_Id BIGINT NOT NULL,
    Modelo_Sillon_Id BIGINT NOT NULL,
    Ventas_Monto DECIMAL(28,2)
);

-- (2) Hechos Compras
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Compras (
    Tiempo_Id BIGINT NOT NULL,
    Tipo_Material_Id BIGINT NOT NULL,
    Sucursal_Id BIGINT NOT NULL,
    Compras_Monto DECIMAL(28,2)
);

-- (3) Hechos Pedidos
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos (
    Tiempo_Id BIGINT NOT NULL,
    Sucursal_Id BIGINT NOT NULL,
    Estado_Pedido_Id BIGINT NOT NULL,
    Turno_Venta_Id BIGINT NOT NULL,
    Pedidos_Cantidad INT
);

-- (4) Hechos Envios
CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios (
    Tiempo_Id BIGINT NOT NULL,
    Ubicacion_Id BIGINT NOT NULL,
    Envios_Cantidad_Total INT,
    Envios_Cantidad_En_Fecha INT,
    Envios_Monto DECIMAL(28,2)
);

-- =================================================
-- CREACIÓN DE CONSTRAINTS PRIMARY KEY - DIMENSIONES
-- =================================================

-- (1) Dimensión Tiempo
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo
ADD CONSTRAINT PK_Dimension_Tiempo
    PRIMARY KEY (Tiempo_Id);

-- (2) Dimensión Cliente
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Cliente
ADD CONSTRAINT PK_Dimension_Cliente
    PRIMARY KEY (Cliente_Id);

-- (3) Dimensión Ubicacion
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion
ADD CONSTRAINT PK_Dimension_Ubicacion
    PRIMARY KEY (Ubicacion_Id);

-- (4) Dimensión Sucursal
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal
ADD CONSTRAINT PK_Dimension_Sucursal
    PRIMARY KEY (Sucursal_Id);
    
-- (5) Dimensión Modelo_Sillon
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon
ADD CONSTRAINT PK_Dimension_Modelo_Sillon
    PRIMARY KEY (Modelo_Sillon_Id);
    
-- (6) Dimensión Tipo_Material
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material
ADD CONSTRAINT PK_Dimension_Tipo_Material
    PRIMARY KEY (Tipo_Material_Id);
    
-- (7) Dimensión Estado_Pedido
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido
ADD CONSTRAINT PK_Dimension_Estado_Pedido
    PRIMARY KEY (Estado_Pedido_Id);
    
-- (8) Dimensión Turno_Venta
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta
ADD CONSTRAINT PK_Dimension_Turno_Venta
    PRIMARY KEY (Turno_Venta_Id);

-- ============================================
-- CREACIÓN DE CONSTRAINTS PRIMARY KEY - HECHOS
-- ============================================

-- (1) Hechos Ventas
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Ventas
ADD CONSTRAINT PK_Hechos_Ventas
    PRIMARY KEY (Tiempo_Id, Sucursal_Id, Ubicacion_Id, Cliente_Id, Modelo_Sillon_Id);

-- (2) Hechos Compras
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Compras
ADD CONSTRAINT PK_Hechos_Compras
    PRIMARY KEY (Tiempo_Id, Sucursal_Id, Tipo_Material_Id);

-- (3) Hechos Pedidos
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos
ADD CONSTRAINT PK_Hechos_Pedidos
    PRIMARY KEY (Tiempo_Id, Sucursal_Id, Estado_Pedido_Id, Turno_Venta_Id);

-- (4) Hechos Envios
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios
ADD CONSTRAINT PK_Hechos_Envios
    PRIMARY KEY (Tiempo_Id, Ubicacion_Id);

-- ============================================
-- CREACIÓN DE CONSTRAINTS FOREIGN KEY - HECHOS
-- ============================================

-- (1) Hechos Ventas
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Ventas
ADD CONSTRAINT FK_Hechos_Ventas_Tiempo 
    FOREIGN KEY (Tiempo_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo(Tiempo_Id),
    CONSTRAINT FK_Hechos_Ventas_Sucursal 
    FOREIGN KEY (Sucursal_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal(Sucursal_Id),
    CONSTRAINT FK_Hechos_Ventas_Ubicacion 
    FOREIGN KEY (Ubicacion_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion(Ubicacion_Id),
    CONSTRAINT FK_Hechos_Ventas_Cliente 
    FOREIGN KEY (Cliente_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Cliente(Cliente_Id),
    CONSTRAINT FK_Hechos_Ventas_Modelo 
    FOREIGN KEY (Modelo_Sillon_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon(Modelo_Sillon_Id);

-- (2) Hechos Compras
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Compras
ADD CONSTRAINT FK_Hechos_Compras_Tiempo 
    FOREIGN KEY (Tiempo_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo(Tiempo_Id),
    CONSTRAINT FK_Hechos_Compras_Sucursal 
    FOREIGN KEY (Sucursal_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal(Sucursal_Id),
    CONSTRAINT FK_Hechos_Compras_TipoMaterial 
    FOREIGN KEY (Tipo_Material_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material(Tipo_Material_Id);

-- (3) Hechos Pedidos
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos
ADD CONSTRAINT FK_Hechos_Pedidos_Tiempo 
    FOREIGN KEY (Tiempo_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo(Tiempo_Id),
    CONSTRAINT FK_Hechos_Pedidos_Sucursal 
    FOREIGN KEY (Sucursal_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal(Sucursal_Id),
    CONSTRAINT FK_Hechos_Pedidos_Estado_Pedido 
    FOREIGN KEY (Estado_Pedido_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido(Estado_Pedido_Id),
    CONSTRAINT FK_Hechos_Pedidos_Turno 
    FOREIGN KEY (Turno_Venta_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta(Turno_Venta_Id);

-- (4) Hechos Envios
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios
ADD CONSTRAINT FK_Hechos_Envios_Tiempo 
    FOREIGN KEY (Tiempo_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo(Tiempo_Id),
    CONSTRAINT FK_Hechos_Envios_Ubicacion 
    FOREIGN KEY (Ubicacion_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion(Ubicacion_Id);

-- =================================
-- CREACIÓN DE ÍNDICES - DIMENSIONES
-- =================================

-- (1) Dimensión Tiempo
CREATE INDEX Indice_Dimension_Tiempo
ON LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo (Tiempo_Anio, Tiempo_Cuatrimestre, Tiempo_Mes);

-- (2) Dimensión Cliente
CREATE INDEX Indice_Dimension_Cliente
ON LOS_POLLOS_HERMANOS.BI_Dimension_Cliente (Cliente_Rango_Etario);

-- (3) Dimensión Ubicacion
CREATE INDEX Indice_Dimension_Ubicacion
ON LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion (Ubicacion_Provincia, Ubicacion_Localidad);

-- (10) Dimensión Turno_Venta
CREATE INDEX Indice_Dimension_Turno_Venta
ON LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta (Turno_Venta_Horario)

-- =====================
-- CREACIÓN DE FUNCIONES
-- =====================
GO
CREATE FUNCTION LOS_POLLOS_HERMANOS.calcularRangoEtario(@fecha_nacimiento datetime2(6))
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @edad int = DATEDIFF(YEAR, @fecha_nacimiento, GETDATE()) - CASE 
    WHEN MONTH(@fecha_nacimiento) > MONTH(GETDATE()) 
            OR (MONTH(@fecha_nacimiento) = MONTH(GETDATE()) AND DAY(@fecha_nacimiento) > DAY(GETDATE())) 
        THEN 1 -- Restamos 1 si todavia no cumplio este año
        ELSE 0 
    END

    IF @edad < 25
        RETURN '<25'
    ELSE IF @edad BETWEEN 25 AND 35
        RETURN '25-35'
    ELSE IF @edad BETWEEN 35 AND 50
        RETURN '35-50'
    RETURN '>50'
END
GO

CREATE FUNCTION LOS_POLLOS_HERMANOS.calcularFranjaHoraria(@fecha datetime2(6))
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @hora INT = DATEPART(HOUR, @fecha);
    DECLARE @franja VARCHAR(20);

    IF @hora >= 8 AND @hora < 14
        SET @franja = '08:00 - 14:00';
    ELSE IF @hora >= 14 AND @hora < 20
        SET @franja = '14:00 - 20:00';
    ELSE
        SET @franja = 'Franja inválida'
        
    RETURN @franja;
END
GO

-- =====================
-- MIGRACIÓN DIMENSIONES
-- =====================

-- (1) Dimensión Tiempo (19 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo(
    Tiempo_Anio,
    Tiempo_Cuatrimestre,
    Tiempo_Mes
)
SELECT
    YEAR(Factura_Fecha),
    CEILING(MONTH(Factura_Fecha) / 4.0),
    MONTH(Factura_Fecha)
FROM LOS_POLLOS_HERMANOS.Factura
GROUP BY 
    YEAR(Factura_Fecha),
    MONTH(Factura_Fecha)
UNION
SELECT
    YEAR(Compra_Fecha),
    CEILING(MONTH(Compra_Fecha) / 4.0),
    MONTH(Compra_Fecha)
FROM LOS_POLLOS_HERMANOS.Compra
GROUP BY 
    YEAR(Compra_Fecha),
    MONTH(Compra_Fecha)
UNION
SELECT 
    YEAR(Envio_Fecha_Entrega),
    CEILING(MONTH(Envio_Fecha_Entrega) / 4.0),
    MONTH(Envio_Fecha_Entrega)
FROM LOS_POLLOS_HERMANOS.Envio
GROUP BY 
    YEAR(Envio_Fecha_Entrega), 
    MONTH(Envio_Fecha_Entrega)
UNION
SELECT 
    YEAR(Envio_Fecha_Programada),
    CEILING(MONTH(Envio_Fecha_Programada) / 4.0),
    MONTH(Envio_Fecha_Programada)
FROM LOS_POLLOS_HERMANOS.Envio
GROUP BY 
    YEAR(Envio_Fecha_Programada),
    MONTH(Envio_Fecha_Programada)
UNION
SELECT 
    YEAR(Pedido_Fecha),
    CEILING(MONTH(Pedido_Fecha) / 4.0),
    MONTH(Pedido_Fecha)
FROM LOS_POLLOS_HERMANOS.Pedido
GROUP BY 
    YEAR(Pedido_Fecha),
    MONTH(Pedido_Fecha);

-- (2) Dimensión Cliente (20509 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Cliente(Cliente_Id, Cliente_Rango_Etario)
SELECT
    Cliente_Codigo,
    LOS_POLLOS_HERMANOS.calcularRangoEtario(Cliente_Fecha_Nacimiento)
FROM LOS_POLLOS_HERMANOS.Cliente;

-- (3) Dimensión Ubicacion (12628 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion(
    Ubicacion_Provincia,
    Ubicacion_Localidad
)
SELECT 
    Ubicacion_Provincia, 
    Ubicacion_Localidad
FROM LOS_POLLOS_HERMANOS.Ubicacion
GROUP BY 
    Ubicacion_Provincia, 
    Ubicacion_Localidad;

-- (4) Dimensión Sucursal (9 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal(
    Sucursal_Id
)
SELECT Sucursal_Codigo
FROM LOS_POLLOS_HERMANOS.Sucursal;

-- (5) Dimensión Modelo_Sillon (7 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon(
    Modelo_Sillon_Id,
    Modelo_Sillon_Descripcion,
    Modelo_Sillon_Precio_Base
)
SELECT 
    Modelo_Codigo,
    Modelo_Descripcion,
    Modelo_Precio_Base
FROM LOS_POLLOS_HERMANOS.Modelo;

-- (6) Dimensión Tipo_Material (9 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material(
    Tipo_Material_Id,
    Tipo_Material_Tipo,
    Tipo_Material_Precio
)
SELECT 
    TipoMaterial_Codigo,
    TipoMaterial_Tipo,
    Material_Precio
FROM LOS_POLLOS_HERMANOS.TipoMaterial
JOIN LOS_POLLOS_HERMANOS.Material ON Material_Tipo = TipoMaterial_Codigo;

-- (7) Dimensión Estado_Pedido (2 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido(
    Estado_Pedido_Estado
)
SELECT Pedido_Estado
FROM LOS_POLLOS_HERMANOS.Pedido
GROUP BY Pedido_Estado;

-- (8) Dimensión Turno_Venta (2 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta(
    Turno_Venta_Horario
)
SELECT 
    LOS_POLLOS_HERMANOS.calcularFranjaHoraria(Pedido_Fecha)
FROM LOS_POLLOS_HERMANOS.Pedido
    WHERE LOS_POLLOS_HERMANOS.calcularFranjaHoraria(Pedido_Fecha) <> 'Franja inválida'
GROUP BY 
    LOS_POLLOS_HERMANOS.calcularFranjaHoraria(Pedido_Fecha);
    
-- ================
-- MIGRACIÓN HECHOS
-- ================

-- (1) Hechos Ventas -> Vistas 1, 2, 3 y 6 (49863 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Hechos_Ventas(
    Tiempo_Id,
    Sucursal_Id,
    Ubicacion_Id,
    Cliente_Id,
    Modelo_Sillon_Id,
    Ventas_Monto
)
SELECT 
    t.Tiempo_Id,
    s.Sucursal_Id,
    u.Ubicacion_Id,
    c.Cliente_Id,
    m.Modelo_Sillon_Id,
    SUM(df.Detalle_Factura_Precio) as ventas_monto
FROM LOS_POLLOS_HERMANOS.DetalleFactura df
JOIN LOS_POLLOS_HERMANOS.Factura f on f.Factura_Numero = df.Detalle_Factura_Factura
JOIN LOS_POLLOS_HERMANOS.DetallePedido dp ON df.Detalle_Factura_Detalle_Pedido = dp.Detalle_Pedido_Numero
JOIN LOS_POLLOS_HERMANOS.Sillon si ON si.Sillon_Codigo = dp.Detalle_Pedido_Sillon
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon m ON m.Modelo_Sillon_Id = si.Sillon_Modelo
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON 
    t.Tiempo_Anio = YEAR(f.Factura_Fecha)
    AND t.Tiempo_Mes = MONTH(f.Factura_Fecha)
    AND t.Tiempo_Cuatrimestre = CEILING(MONTH(f.Factura_Fecha)/4.0)
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s ON s.Sucursal_Id = f.Factura_Sucursal
JOIN LOS_POLLOS_HERMANOS.Sucursal su ON s.Sucursal_Id = su.Sucursal_Codigo
JOIN LOS_POLLOS_HERMANOS.Ubicacion ub ON su.Sucursal_Ubicacion = ub.Ubicacion_Codigo
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion u ON 
    u.Ubicacion_Provincia = ub.Ubicacion_Provincia
    AND u.Ubicacion_Localidad = ub.Ubicacion_Localidad
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Cliente c ON c.Cliente_Id = f.Factura_Cliente
GROUP BY 
	t.Tiempo_Id,
	s.Sucursal_Id,
    u.Ubicacion_Id,
    c.Cliente_Id,
    m.Modelo_Sillon_Id;


-- (2) Hechos Compras -> Vistas 1, 7 y 8 (612 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Hechos_Compras(
    Tiempo_Id,
    Sucursal_Id,
    Tipo_Material_Id,
    Compras_Monto
)
SELECT
    t.Tiempo_Id,
    s.Sucursal_Id,
    tm.Tipo_Material_Id,
    SUM(dc.Detalle_Compra_Subtotal)
FROM LOS_POLLOS_HERMANOS.DetalleCompra dc
JOIN LOS_POLLOS_HERMANOS.Compra c on c.Compra_Numero = dc.Detalle_Compra_Compra
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s ON s.Sucursal_Id = c.Compra_Sucursal
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON 
    t.Tiempo_Anio = YEAR(c.Compra_Fecha)
    AND t.Tiempo_Mes = MONTH(c.Compra_Fecha)
    AND t.Tiempo_Cuatrimestre = CEILING(MONTH(c.Compra_Fecha) / 4.0)
JOIN LOS_POLLOS_HERMANOS.Material m ON m.Material_Codigo = dc.Detalle_Compra_Material
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material tm ON tm.Tipo_Material_Id = m.Material_Tipo
GROUP BY
    t.Tiempo_Id,
    s.Sucursal_Id,
    tm.Tipo_Material_Id;


-- (3) Hechos Pedidos -> Vistas 4, 5 y 6 (681 rows)
INSERT INTO LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos(
    Tiempo_Id,
    Sucursal_Id,
    Estado_Pedido_Id,
    Turno_Venta_Id,
    Pedidos_Cantidad
)
SELECT
    t.Tiempo_Id,
    s.Sucursal_Id,
    ep.Estado_Pedido_Id,
    tv.Turno_Venta_Id,
    COUNT(p.Pedido_Numero)
FROM LOS_POLLOS_HERMANOS.Pedido p
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON 
    t.Tiempo_Anio = YEAR(p.Pedido_Fecha)
    AND t.Tiempo_Mes = MONTH(p.Pedido_Fecha)
    AND t.Tiempo_Cuatrimestre = CEILING(MONTH(p.Pedido_Fecha) / 4.0)
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s ON s.Sucursal_Id = p.Pedido_Sucursal
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido ep ON ep.Estado_Pedido_Estado = p.Pedido_Estado 
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta tv ON tv.Turno_Venta_Horario = LOS_POLLOS_HERMANOS.calcularFranjaHoraria(p.Pedido_Fecha)
GROUP BY
    t.Tiempo_Id,
    s.Sucursal_Id,
    ep.Estado_Pedido_Id,
    tv.Turno_Venta_Id;


-- TODO: Arreglar warning 
-- (4) Hechos Envios -> Vistas 9 y 10 (16752 rows) 
INSERT INTO LOS_POLLOS_HERMANOS.BI_Hechos_Envios(
    Tiempo_Id,
    Ubicacion_Id,
    Envios_Cantidad_Total,
    Envios_Cantidad_En_Fecha,
    Envios_Monto
)
SELECT
    t.Tiempo_Id,
    u.Ubicacion_Id,
    COUNT(e.Envio_Numero),
    SUM(CASE WHEN e.Envio_Fecha_Entrega <= e.Envio_Fecha_Programada THEN 1 ELSE 0 END),
    SUM(e.Envio_Total)
FROM LOS_POLLOS_HERMANOS.Envio e
JOIN LOS_POLLOS_HERMANOS.Factura f ON f.Factura_Numero = e.Envio_Factura
JOIN LOS_POLLOS_HERMANOS.Cliente c ON c.Cliente_Codigo = f.Factura_Cliente
JOIN LOS_POLLOS_HERMANOS.Ubicacion ub ON ub.Ubicacion_Codigo = c.Cliente_Ubicacion
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion u 
    ON u.Ubicacion_Provincia = ub.Ubicacion_Provincia 
    AND u.Ubicacion_Localidad = ub.Ubicacion_Localidad
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t 
    ON t.Tiempo_Anio = YEAR(e.Envio_Fecha_Entrega)
    AND t.Tiempo_Mes = MONTH(e.Envio_Fecha_Entrega)
    AND t.Tiempo_Cuatrimestre = CEILING(MONTH(e.Envio_Fecha_Entrega) / 4.0)
GROUP BY
    t.Tiempo_Id,
    u.Ubicacion_Id;

/*
Ver si esto resuelve la warning
INSERT INTO LOS_POLLOS_HERMANOS.BI_Hechos_Envios(
    Tiempo_Id,
    Ubicacion_Id,
    Envios_Cantidad_Total,
    Envios_Cantidad_En_Fecha,
    Envios_Monto
)
SELECT
    t.Tiempo_Id,
    u.Ubicacion_Id,
    COUNT(ISNULL(e.Envio_Numero, 0)),
    COUNT(CASE WHEN e.Envio_Fecha_Entrega IS NOT NULL AND e.Envio_Fecha_Programada IS NOT NULL AND e.Envio_Fecha_Entrega <= e.Envio_Fecha_Programada THEN 1 END),
    SUM(ISNULL(e.Envio_Total, 0))
FROM LOS_POLLOS_HERMANOS.Envio e
JOIN LOS_POLLOS_HERMANOS.Factura f ON f.Factura_Numero = e.Envio_Factura
JOIN LOS_POLLOS_HERMANOS.Cliente c ON c.Cliente_Codigo = f.Factura_Cliente
JOIN LOS_POLLOS_HERMANOS.Ubicacion ub ON ub.Ubicacion_Codigo = c.Cliente_Ubicacion
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion u 
    ON u.Ubicacion_Provincia = ub.Ubicacion_Provincia 
    AND u.Ubicacion_Localidad = ub.Ubicacion_Localidad
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t 
    ON t.Tiempo_Anio = YEAR(ISNULL(e.Envio_Fecha_Entrega, '2000-01-01'))
    AND t.Tiempo_Mes = MONTH(ISNULL(e.Envio_Fecha_Entrega, '2000-01-01'))
    AND t.Tiempo_Cuatrimestre = CEILING(MONTH(ISNULL(e.Envio_Fecha_Entrega, '2000-01-01')) / 4.0)
WHERE
    t.Tiempo_Id IS NOT NULL
    AND u.Ubicacion_Id IS NOT NULL
    AND ISNULL(e.Envio_Numero, 0) IS NOT NULL
    AND e.Envio_Fecha_Entrega IS NOT NULL
    AND e.Envio_Fecha_Programada IS NOT NULL
    AND e.Envio_Total IS NOT NULL
    AND f.Factura_Numero IS NOT NULL
    AND c.Cliente_Codigo IS NOT NULL
    AND ub.Ubicacion_Codigo IS NOT NULL
GROUP BY
    t.Tiempo_Id,
    u.Ubicacion_Id;

*/


/*
V I S T A S
1- Ganancias:
    Por: Mes y Sucursal
    Queremos: Ganancia Total

    Usamos:
        Hechos_Ventas
        Hechos_Compras

    Group By:
        Mes, Sucursal


    vista:
    (select sum(factura_total) - sum(compra_total) from hechos_ventas
    join hechos_compras on
        hechos_ventas_mes = hechos_compras_mes
        and hechos_ventas_sucursal = hechos_compras_sucursal 

2- Factura Promedio Mensual:
    Por Provincia de Sucursal, Cuatrimestre, Año

    Usamos:
        Hechos_Ventas

    Group By:
        u.Provincia, t.Cuatrimestre, t.Año

    Select de avg(MontoFactura)


3- Rendimiento de Modelos: 
    Por: Cuatrimestre, Año, Localidad, Rango Etario de Cliente
    Queremos: Top 3 de modelos, ordenado por total vendido de ese modelo

    Usamos:
        Hechos_Ventas 
            Group By: t.Cuatrimestre, t.Año, u.Localidad, c.Rango Etario de Cliente
    
    Ordenamos por Sum Ventas_Monto desc

4- Volumen de Pedidos:
    Por: Turno, Sucursal, Mes, Año
    Queremos: Cantidad de pedidos registrados

    Usamos:
        SUM(Pedidos_Cantidad)
            Group By: Turno, Sucursal, Mes, Año

5- Conversión de Pedidos:
    Por: Estado, Cuatrimestre, Sucursal
    Queremos: Porcentaje de pedidos

    Usamos: Pedidos_Cantidad / Total
        Group by: Estado, Cuatrimestre, Sucursal

6- Tiempo Promedio de Fabricacion:
    Por: Sucursal, Cuatrimestre
    Queremos: Tiempo promedio entre tiempo de pedido y tiempo de facturacion

    El problema es que Dimension Tiempo no tiene el dia, solo el mes y el año.

    Usamos:
        Hechos_Pedidos
        Hechos_Ventas
            Join con Hechos_Pedidos por Sucursal_Id

    
    CREATE FUNCTION LOS_POLLOS_HERMANOS.diferenciaDiasEntreTiempos(@TiempoId1 BIGINT, @TiempoId2 BIGINT)
    RETURNS FLOAT
    AS
    BEGIN
        DECLARE @Fecha1 DATE, @Fecha2 DATE;

        SELECT @Fecha1 = DATEFROMPARTS(Tiempo_Anio, Tiempo_Mes, 1)
        FROM LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo
        WHERE Tiempo_Id = @TiempoId1;

        SELECT @Fecha2 = DATEFROMPARTS(Tiempo_Anio, Tiempo_Mes, 1)
        FROM LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo
        WHERE Tiempo_Id = @TiempoId2;

        RETURN DATEDIFF(DAY, @Fecha1, @Fecha2) * 1.0;
    END
    GO

    Avg(LOS_POLLOS_HERMANOS.diferenciaDiasEntreTiempos(Hechos_Pedidos.Tiempo_Id, Hechos_Ventas.Tiempo_Id))

7- Promedio de Compras:
    Por: Mes
    Queremos: Importe promedio de compras

    Usamos:
        Hechos_Compras
            Group By: Mes
            
    AVG(Compras_Monto)

8- Compras por Tipo de Material:
    Por: Tipo de Material, Sucursal, Cuatrimestre
    Queremos: Importe total de compras por tipo de material
    Usamos:
        Hechos_Compras
            Group By: Tipo de Material, Sucursal, Cuatrimestre
    SUM(Compras_Monto)

9- Porcentaje de cumplimientos de Envíos:
    Por: Mes
    Queremos: Porcentaje de cumplimientos

    Usamos:
        Envios_En_Fecha * 100 /Envios_Totales
        Group by: Mes

10- Localidades que pagan mayor costo de envio:
    Por: Localidad
    Queremos: Top 3 localidades (de cliente) con mayor pormedio de costo de envio (total)

    Usamos:
        Hechos_Envios
            Group By: Localidad
    AVG(Envios_Monto)
    Order by: AVG(Envios_Monto) desc
    TOP 3
*/