USE GD1C2025
GO

-- ============================
-- RESET DEL MODELO BI COMPLETO
-- ============================

-- 1. DROPEAR VISTAS (dependen de tablas de hechos y dimensiones)
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Ganancias', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Ganancias;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Factura_Promedio_Mensual', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Factura_Promedio_Mensual;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Rendimiento_Modelos', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Rendimiento_Modelos;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Volumen_Pedidos', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Volumen_Pedidos;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Conversion_Pedidos', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Conversion_Pedidos;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Tiempo_Promedio_Fabricacion', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Tiempo_Promedio_Fabricacion;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Promedio_Compras', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Promedio_Compras;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Compras_Tipo_Material', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Compras_Tipo_Material;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Porcentaje_Cumplimiento_Envios', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Porcentaje_Cumplimiento_Envios;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Vista_Localidades_Mayor_Costo_Envio', 'V') IS NOT NULL
    DROP VIEW LOS_POLLOS_HERMANOS.BI_Vista_Localidades_Mayor_Costo_Envio;

-- 2. DROPEAR TABLAS DE HECHOS (primero quitar constraints FK)
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Ventas', 'U') IS NOT NULL
BEGIN
    ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Ventas NOCHECK CONSTRAINT ALL;
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Ventas;
END
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Compras', 'U') IS NOT NULL
BEGIN
    ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Compras NOCHECK CONSTRAINT ALL;
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Compras;
END
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos', 'U') IS NOT NULL
BEGIN
    ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos NOCHECK CONSTRAINT ALL;
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos;
END
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Hechos_Envios', 'U') IS NOT NULL
BEGIN
    ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios NOCHECK CONSTRAINT ALL;
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios;
END

-- 3. DROPEAR TABLAS DE DIMENSIONES (después de hechos)
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Cliente', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Cliente;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta', 'U') IS NOT NULL
    DROP TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta;

-- 4. DROPEAR FUNCIONES
IF OBJECT_ID('LOS_POLLOS_HERMANOS.calcularRangoEtario', 'FN') IS NOT NULL
    DROP FUNCTION LOS_POLLOS_HERMANOS.calcularRangoEtario;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.calcularFranjaHoraria', 'FN') IS NOT NULL
    DROP FUNCTION LOS_POLLOS_HERMANOS.calcularFranjaHoraria;

-- 5. DROPEAR STORED PROCEDURES
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Datos_BI', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Datos_BI;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Hechos_Ventas', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Ventas;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Hechos_Compras', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Compras;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Hechos_Pedidos', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Pedidos;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Hechos_Envios', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Envios;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Tiempo', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Tiempo;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Cliente', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Cliente;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Ubicacion', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Ubicacion;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Sucursal', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Sucursal;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Modelo_Sillon', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Modelo_Sillon;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Tipo_Material', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Tipo_Material;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Estado_Pedido', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Estado_Pedido;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Migrar_Dimension_Turno_Venta', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Turno_Venta;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tablas_BI', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tablas_BI;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tiempo', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tiempo;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Cliente', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Cliente;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Ubicacion', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Ubicacion;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Sucursal', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Sucursal;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Modelo_Sillon', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Modelo_Sillon;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tipo_Material', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tipo_Material;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Estado_Pedido', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Estado_Pedido;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Turno_Venta', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Turno_Venta;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Ventas', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Ventas;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Compras', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Compras;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Pedidos', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Pedidos;
IF OBJECT_ID('LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Envios', 'P') IS NOT NULL
    DROP PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Envios;
GO
-- ===================================
-- CREACIÓN DE TABLAS BI - DIMENSIONES
-- ===================================

-- (1) Dimensión Tiempo
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tiempo AS
BEGIN
	CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo (
		Tiempo_Id BIGINT IDENTITY(1,1) NOT NULL,
		Tiempo_Anio SMALLINT,
		Tiempo_Cuatrimestre TINYINT,
		Tiempo_Mes TINYINT
	);
END
GO
-- Almacenamos los períodos de tiempo (año, cuatrimestre y mes)
-- Permite analizar la información de ventas, compras, pedidos y envíos a lo largo del tiempo.

-- (2) Dimensión Cliente
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Cliente AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Cliente (
        Cliente_Id BIGINT NOT NULL,
        Cliente_Rango_Etario VARCHAR(10)
    );
END
GO
-- Almacena los clientes y su rango etario (<25, 25-35, 35-50, >50).
-- El rango etario se utiliza en los hechos de ventas y en la vista de rendimiento de modelos (BI_Vista_Rendimiento_Modelos)
-- Permite obtener los modelos más vendidos según el grupo etario.


-- (3) Dimensión Ubicacion
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Ubicacion AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion (
        Ubicacion_Id BIGINT IDENTITY(1,1) NOT NULL, -- Usamos identity porque se repite por dirección en el modelo OLTP
        Ubicacion_Provincia NVARCHAR(255),
        Ubicacion_Localidad NVARCHAR(255)
    );
END
GO
-- Almacena las provincias y localidades de clientes y sucursales.
-- Se utiliza en los hechos de ventas y envíos
-- Tambien en vistas como BI_Vista_Factura_Promedio_Mensual y BI_Vista_Localidades_Mayor_Costo_Envio
-- Permite realizar un análisis por región y detectar tendencias geográficas.

-- (4) Dimensión Sucursal
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Sucursal AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal (
        Sucursal_Id BIGINT NOT NULL,
        Sucursal_Telefono NVARCHAR(255),
        Sucursal_Mail NVARCHAR(255)
    );
END
GO
-- Almacena los datos de cada sucursal.
-- Se utiliza en los hechos de ventas, compras y pedidos
-- También vistas como BI_Vista_Ganancias, BI_Vista_Volumen_Pedidos y BI_Vista_Conversion_Pedidos
-- Permite comparar el desempeño entre sucursales.


-- (5) Dimensión Modelo_Sillon
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Modelo_Sillon AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon (
        Modelo_Sillon_Id BIGINT NOT NULL,
        Modelo_Sillon_Descripcion NVARCHAR(255)
    );
END
GO
-- Almacena los modelos de sillón ofrecidos por la fábrica.
-- Se utiliza en los hechos de ventas 
-- También en la vista BI_Vista_Rendimiento_Modelos
-- Permite identificar los modelos más vendidos y analizar preferencias de los clientes.

-- (6) Dimensión Tipo_Material
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tipo_Material AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material (
        Tipo_Material_Id BIGINT NOT NULL,
        Tipo_Material_Tipo NVARCHAR(255)
    );
END
GO

-- (7) Dimensión Estado_Pedido
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Estado_Pedido AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido (
        Estado_Pedido_Id BIGINT IDENTITY(1,1) NOT NULL,
        Estado_Pedido_Estado NVARCHAR(255),
    );
END
GO
-- Almacena los tipos de materiales (tela, madera, relleno, etc.).
-- Se utiliza en los hechos de compras 
-- También en las vistas BI_Vista_Compras_Tipo_Material y BI_Vista_Promedio_Compras
-- Permite analizar el gasto y consumo de materiales por tipo y período.


-- (8) Dimensión Turno_Venta
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Turno_Venta AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta (
        Turno_Venta_Id BIGINT IDENTITY(1,1) NOT NULL,
        Turno_Venta_Horario VARCHAR(20)
    );
END
GO
-- Almacena las franjas horarias (turnos) de ventas (08:00-14:00, 14:00-20:00).
-- Se utiliza en los hechos de pedidos 
-- También en la vista BI_Vista_Volumen_Pedidos
-- Permite analizar el volumen de pedidos según el turno y detectar patrones de demanda a lo largo del día.


-- ==============================
-- CREACIÓN DE TABLAS BI - HECHOS
-- ==============================

-- (1) Hechos Ventas
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Ventas AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Ventas (
        Tiempo_Id BIGINT NOT NULL,
        Sucursal_Id BIGINT NOT NULL,
        Ubicacion_Id BIGINT NOT NULL,
        Cliente_Id BIGINT NOT NULL,
        Modelo_Sillon_Id BIGINT NOT NULL,
        Ventas_Monto DECIMAL(28,2),
        Ventas_Cantidad DECIMAL(18,0),
        Ventas_Tiempo_Fabricacion TINYINT
    );
END
GO
-- Registra los hechos de ventas según período tiempo, sucursal, ubicación, cliente y modelo de sillón.
-- Incluye el monto total de ventas, la cantidad vendida y el tiempo de fabricación promedio.
-- Se utiliza en vistas como BI_Vista_Ganancias, BI_Vista_Factura_Promedio_Mensual, BI_Vista_Rendimiento_Modelos y BI_Vista_Tiempo_Promedio_Fabricacion.
-- Permite analizar el desempeño de ventas desde distintas dimensiones.

-- (2) Hechos Compras
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Compras AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Compras (
        Tiempo_Id BIGINT NOT NULL,
        Tipo_Material_Id BIGINT NOT NULL,
        Sucursal_Id BIGINT NOT NULL,
        Compras_Monto DECIMAL(28,2)
    );
END
GO
-- Registra los hechos de compras según período tiempo, tipo de material y sucursal.
-- Guarda el monto total de compras realizadas.
-- Se utiliza en vistas como BI_Vista_Ganancias, BI_Vista_Promedio_Compras y BI_Vista_Compras_Tipo_Material.
-- Permite analizar el gasto en materiales por sucursal y período.

-- (3) Hechos Pedidos
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Pedidos AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos (
        Tiempo_Id BIGINT NOT NULL,
        Sucursal_Id BIGINT NOT NULL,
        Estado_Pedido_Id BIGINT NOT NULL,
        Turno_Venta_Id BIGINT NOT NULL,
        Pedidos_Cantidad INT
    );
END
GO
-- Registra los hechos de pedidos según período tiempo, sucursal, estado del pedido y turno de venta.
-- Guarda la cantidad de pedidos realizados.
-- Se utiliza en vistas como BI_Vista_Volumen_Pedidos, BI_Vista_Conversion_Pedidos y BI_Vista_Tiempo_Promedio_Fabricacion.
-- Permite analizar el volumen y conversión de pedidos por franja horaria, sucursal y estado.

-- (4) Hechos Envios
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Envios AS
BEGIN
    CREATE TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios (
        Tiempo_Id BIGINT NOT NULL,
        Ubicacion_Id BIGINT NOT NULL,
        Envios_Cantidad_Total INT,
        Envios_Cantidad_En_Fecha INT,
        Envios_Monto DECIMAL(28,2)
    );
END
GO
-- Registra los hechos de envíos según período de tiempo y la ubicación de destino.
-- Incluye la cantidad total de envíos, los envíos entregados en fecha y el monto total de envíos.
-- Se utiliza en vistas como BI_Vista_Porcentaje_Cumplimiento_Envios y BI_Vista_Localidades_Mayor_Costo_Envio.
-- Permite analizar el cumplimiento y el costo de los envíos por localidad y período.

-- Stored procedure que ejecuta los stored procedures para crear todas las tablas
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Crear_Tablas_BI AS
BEGIN
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tiempo;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Cliente;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Ubicacion;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Sucursal;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Modelo_Sillon;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Tipo_Material;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Estado_Pedido;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Dimension_Turno_Venta;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Ventas;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Compras;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Pedidos;
    EXEC LOS_POLLOS_HERMANOS.Crear_Tabla_Hechos_Envios;
END
GO

-- Ejecución del stored procedure que crea todas las tablas
EXEC LOS_POLLOS_HERMANOS.Crear_Tablas_BI;
GO


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
-- Relaciona la tabla de hechos de ventas con las dimensiones de Tiempo, Sucursal, Ubicación, Cliente y Modelo de Sillón.

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
-- Relaciona la tabla de hechos de compras con las dimensiones de Tiempo, Sucursal y Tipo de Material.

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
-- Relaciona la tabla de hechos de pedidos con las dimensiones de Tiempo, Sucursal, Estado del Pedido y Turno de Venta.

-- (4) Hechos Envios
ALTER TABLE LOS_POLLOS_HERMANOS.BI_Hechos_Envios
ADD CONSTRAINT FK_Hechos_Envios_Tiempo 
    FOREIGN KEY (Tiempo_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo(Tiempo_Id),
    CONSTRAINT FK_Hechos_Envios_Ubicacion 
    FOREIGN KEY (Ubicacion_Id) 
    REFERENCES LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion(Ubicacion_Id);
-- Relaciona la tabla de hechos de envíos con las dimensiones de Tiempo y Ubicación.

-- =================================
-- CREACIÓN DE ÍNDICES - DIMENSIONES
-- =================================

-- (1) Dimensión Tiempo
CREATE INDEX Indice_Dimension_Tiempo
ON LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo (Tiempo_Anio, Tiempo_Cuatrimestre, Tiempo_Mes);
-- Creamos un índice compuesto sobre Año, Cuatrimestre y Mes para optimizar búsquedas por períodos de tiempo en los análisis BI

-- (2) Dimensión Cliente
CREATE INDEX Indice_Dimension_Cliente
ON LOS_POLLOS_HERMANOS.BI_Dimension_Cliente (Cliente_Rango_Etario);
-- Índice sobre el rango etario del cliente para agilizar consultas y segmentaciones por grupo de edad

-- (3) Dimensión Ubicacion
CREATE INDEX Indice_Dimension_Ubicacion
ON LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion (Ubicacion_Provincia, Ubicacion_Localidad);
-- Índice compuesto sobre provincia y localidad para facilitar búsquedas y análisis geográficos en BI

-- (4) Dimensión Sucursal
-- No necesita la creación de un índice porque las búsquedas se realizan por su clave primaria

-- (5) Dimensión Modelo_Sillon
-- No necesita la creación de un índice porque las búsquedas se realizan por su clave primaria

-- (6) Dimensión Tipo_Material
-- No necesita la creación de un índice porque las búsquedas se realizan por su clave primaria

-- (7) Dimensión Estado_Pedido
-- No necesita la creación de un índice porque las búsquedas se realizan por su clave primaria

-- (8) Dimensión Turno_Venta
CREATE INDEX Indice_Dimension_Turno_Venta
ON LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta (Turno_Venta_Horario);
-- Índice sobre el horario del turno de venta para agilizar consultas por franja horaria en el análisis de pedidos

-- ============================
-- CREACIÓN DE ÍNDICES - HECHOS
-- ============================

-- (1) Hechos Ventas
CREATE INDEX Indice_Hechos_Ventas
ON LOS_POLLOS_HERMANOS.BI_Hechos_Ventas (Ventas_Monto, Ventas_Cantidad, Ventas_Tiempo_Fabricacion);
-- Índice sobre monto, cantidad y tiempo de fabricación para optimizar consultas de ventas y análisis de rendimiento

-- (2) Hechos Compras
CREATE INDEX Indice_Hechos_Compras
ON LOS_POLLOS_HERMANOS.BI_Hechos_Compras (Compras_Monto);
-- Índice sobre el monto de compras para optimizar consultas y análisis de gastos en materiales

-- (3) Hechos Pedidos
CREATE INDEX Indice_Hechos_Pedidos
ON LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos (Pedidos_Cantidad);
-- Índice sobre la cantidad de pedidos para optimizar consultas y análisis de volumen de pedidos

-- (4) Hechos Envios
CREATE INDEX Indice_Hechos_Envios
ON LOS_POLLOS_HERMANOS.BI_Hechos_Envios (Envios_Cantidad_Total, Envios_Cantidad_En_Fecha, Envios_Monto);
-- Índice sobre cantidad total, cantidad en fecha y monto de envíos para optimizar consultas y análisis de cumplimiento de envíos

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
        THEN 1 -- Restamos 1 si todavía no cumplió este año
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
-- Esta función recibe una fecha de nacimiento y devuelve el rango etario correspondiente
-- ('<25', '25-35', '35-50', '>50') según la edad calculada.
-- Se utiliza durante la migración de datos para asignar el rango etario a cada cliente
-- en la dimensión BI_Dimension_Cliente, permitiendo segmentar y analizar ventas y preferencias
-- por grupo de edad en las consultas y vistas del modelo BI.


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
-- Esta función recibe una fecha y devuelve la franja horaria correspondiente
-- ('08:00 - 14:00', '14:00 - 20:00') según la hora extraída de la fecha.
-- Se utiliza durante la migración de datos para asignar el turno de venta a cada pedido
-- en la dimensión BI_Dimension_Turno_Venta, permitiendo segmentar y analizar el volumen
-- de pedidos y ventas por franja horaria en las consultas y vistas del modelo BI.


-- =====================
-- MIGRACIÓN DIMENSIONES
-- =====================

-- (1) Dimensión Tiempo (19 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Tiempo AS
BEGIN
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
END
GO
-- Insertamos todos los períodos únicos de año, cuatrimestre y mes
-- presentes en las tablas Factura, Compra, Envio y Pedido.
-- Esto asegura que la dimensión contenga todos los períodos relevantes
-- para el análisis de ventas, compras, pedidos y envíos.
-- Permite un análisis temporal en todas las vistas del BI.


-- (2) Dimensión Cliente (20509 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Cliente AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Cliente(Cliente_Id, Cliente_Rango_Etario)
    SELECT
        Cliente_Codigo,
        LOS_POLLOS_HERMANOS.calcularRangoEtario(Cliente_Fecha_Nacimiento)
    FROM LOS_POLLOS_HERMANOS.Cliente;
END
GO
-- Insertamos todos los clientes junto con su rango etario calculado.
-- Permite segmentar y analizar ventas por grupo de edad.
-- Utilizado para vistas como BI_Vista_Rendimiento_Modelos.

-- (3) Dimensión Ubicacion (12628 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Ubicacion AS
BEGIN
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
END
GO
-- Insertamos todas las combinaciones únicas de provincia y localidad.
-- Permite analizar indicadores por región y localidad.
-- Utilizado para vistas como BI_Vista_Factura_Promedio_Mensual y BI_Vista_Localidades_Mayor_Costo_Envio.

-- (4) Dimensión Sucursal (9 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Sucursal AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal(
        Sucursal_Id,
        Sucursal_Telefono,
        Sucursal_Mail
    )
    SELECT 
        Sucursal_Codigo,
        Sucursal_Telefono,
        Sucursal_Mail
    FROM LOS_POLLOS_HERMANOS.Sucursal;
END
GO
-- Insertamos todas las sucursales con sus datos de contacto.
-- Permite analizar y comparar indicadores por sucursal.
-- Utilizado en vistas como BI_Vista_Ganancias, BI_Vista_Volumen_Pedidos y BI_Vista_Conversion_Pedidos.

-- (5) Dimensión Modelo_Sillon (7 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Modelo_Sillon AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon(
        Modelo_Sillon_Id,
        Modelo_Sillon_Descripcion
    )
    SELECT 
        Modelo_Codigo,
        Modelo_Descripcion
    FROM LOS_POLLOS_HERMANOS.Modelo;
END
GO
-- Insertamos todos los modelos de sillón disponibles.
-- Permite analizar ventas y preferencias por modelo.
-- Utilizado en vistas como BI_Vista_Rendimiento_Modelos.

-- (6) Dimensión Tipo_Material (9 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Tipo_Material AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material(
        Tipo_Material_Id,
        Tipo_Material_Tipo
    )
    SELECT 
        TipoMaterial_Codigo,
        TipoMaterial_Tipo
    FROM LOS_POLLOS_HERMANOS.TipoMaterial
    JOIN LOS_POLLOS_HERMANOS.Material ON Material_Tipo = TipoMaterial_Codigo;
END
GO
-- Insertamos todos los tipos de material utilizados en los materiales.
-- Permite analizar compras y gastos por tipo de material.
-- Utilizado en vistas como BI_Vista_Compras_Tipo_Material y BI_Vista_Promedio_Compras.

-- (7) Dimensión Estado_Pedido (2 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Estado_Pedido AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido(
        Estado_Pedido_Estado
    )
    SELECT Pedido_Estado
    FROM LOS_POLLOS_HERMANOS.Pedido
    GROUP BY Pedido_Estado;
END
GO
-- Insertamos todos los estados de pedido distintos.
-- Permite analizar la conversión y seguimiento de pedidos por estado.
-- Utilizado en vistas como BI_Vista_Conversion_Pedidos.

-- (8) Dimensión Turno_Venta (2 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Dimension_Turno_Venta AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta(
        Turno_Venta_Horario
    )
    SELECT 
        LOS_POLLOS_HERMANOS.calcularFranjaHoraria(Pedido_Fecha)
    FROM LOS_POLLOS_HERMANOS.Pedido
        WHERE LOS_POLLOS_HERMANOS.calcularFranjaHoraria(Pedido_Fecha) <> 'Franja inválida' -- No tenemos en cuenta aquellas que no estén en los rangos 08:00 - 14:00 o 14:00 - 20:00
    GROUP BY 
        LOS_POLLOS_HERMANOS.calcularFranjaHoraria(Pedido_Fecha);
END
GO
-- Insertamos todas las franjas horarias (turnos) detectadas en los pedidos.
-- Permite analizar el volumen de pedidos por franja horaria.
-- Utilizado en vistas como BI_Vista_Volumen_Pedidos.

-- ================
-- MIGRACIÓN HECHOS
-- ================

-- (1) Hechos Ventas -> Vistas 1, 2, 3 y 6 (49863 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Ventas AS
BEGIN
    INSERT INTO LOS_POLLOS_HERMANOS.BI_Hechos_Ventas(
        Tiempo_Id,
        Sucursal_Id,
        Ubicacion_Id,
        Cliente_Id,
        Modelo_Sillon_Id,
        Ventas_Monto,
        Ventas_Cantidad,
        Ventas_Tiempo_Fabricacion
    )
    SELECT
        t.Tiempo_Id,
        s.Sucursal_Id,
        u.Ubicacion_Id,
        c.Cliente_Id,
        m.Modelo_Sillon_Id,
        SUM(df.Detalle_Factura_Subtotal),    
        SUM(df.Detalle_Factura_Cantidad),
        AVG(DATEDIFF(DAY, p.Pedido_fecha, f.Factura_Fecha))
    FROM LOS_POLLOS_HERMANOS.DetalleFactura df
    JOIN LOS_POLLOS_HERMANOS.Factura f ON f.Factura_Numero = df.Detalle_Factura_Factura
    JOIN LOS_POLLOS_HERMANOS.DetallePedido dp ON df.Detalle_Factura_Detalle_Pedido = dp.Detalle_Pedido_Numero
    JOIN LOS_POLLOS_HERMANOS.Pedido p ON p.Pedido_Numero = dp.Detalle_Pedido_Pedido
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
END
GO
-- Migramos los hechos de ventas desde el modelo transaccional a la tabla BI_Hechos_Ventas.
-- Calculamos el monto total, la cantidad vendida y el tiempo promedio de fabricación
-- por combinación de período, sucursal, ubicación, cliente y modelo de sillón.
-- Relacionamos cada venta con sus dimensiones correspondientes mediante JOINs.
-- Esta migración permite analizar ventas, ganancias, rendimiento de modelos y tiempos de fabricación
-- Utilizado en las vistas:
--  BI_Vista_Ganancias,
--  BI_Vista_Factura_Promedio_Mensual,
--  BI_Vista_Rendimiento_Modelos,
--  BI_Vista_Tiempo_Promedio_Fabricacion

-- (2) Hechos Compras -> Vistas 1, 7 y 8 (612 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Compras AS
BEGIN
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
END
GO
-- Migramos los hechos de compras desde el modelo transaccional a la tabla BI_Hechos_Compras.
-- Calculamos el monto total de compras por combinación de período, sucursal y tipo de material.
-- Relacionamos cada compra con sus dimensiones correspondientes mediante JOINs.
-- Esta migración permite analizar gastos en materiales y compras por período, sucursal y tipo de material.
-- Utilizado en las vistas:
--  BI_Vista_Ganancias,
--  BI_Vista_Promedio_Compras,
--  BI_Vista_Compras_Tipo_Material

-- (3) Hechos Pedidos -> Vistas 4, 5 y 6 (681 rows)
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Pedidos AS
BEGIN
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
END
GO
-- Migramos los hechos de pedidos desde el modelo transaccional a la tabla BI_Hechos_Pedidos.
-- Calculamos la cantidad de pedidos por combinación de período, sucursal, estado del pedido y turno de venta.
-- Relacionamos cada pedido con sus dimensiones correspondientes mediante JOINs.
-- Esta migración permite analizar el volumen y la conversión de pedidos por franja horaria, sucursal y estado.
-- Utilizado en las vistas:
--  BI_Vista_Volumen_Pedidos,
--  BI_Vista_Conversion_Pedidos,
--  BI_Vista_Tiempo_Promedio_Fabricacion

-- (4) Hechos Envios -> Vistas 9 y 10 (16752 rows) 
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Hechos_Envios AS
BEGIN
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
END
GO
-- Migramos los hechos de envíos desde el modelo transaccional a la tabla BI_Hechos_Envios.
-- Calculamos la cantidad total de envíos, la cantidad entregada en fecha y el monto total por combinación de período y ubicación.
-- Relacionamos cada envío con sus dimensiones correspondientes mediante JOINs.
-- Utilizamos GROUP BY para consolidar los datos y evitar duplicados.
-- Esta migración permite analizar el cumplimiento y el costo de los envíos por localidad y período.
-- Utilizado en las vistas:
--  BI_Vista_Porcentaje_Cumplimiento_Envios,
--  BI_Vista_Localidades_Mayor_Costo_Envio

-- Stored procedure que engloba todas las migraciones
CREATE PROCEDURE LOS_POLLOS_HERMANOS.Migrar_Datos_BI AS
BEGIN
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Tiempo;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Cliente;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Ubicacion;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Sucursal;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Modelo_Sillon;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Tipo_Material;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Estado_Pedido;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Dimension_Turno_Venta;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Hechos_Ventas;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Hechos_Compras;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Hechos_Pedidos;
    EXEC LOS_POLLOS_HERMANOS.Migrar_Hechos_Envios;
END
GO

-- Ejecución de Stored Procedure de migración de datos
EXEC LOS_POLLOS_HERMANOS.Migrar_Datos_BI;
GO


-- ===============
-- CREACIÓN VISTAS
-- ===============

-- (1) Ganancias (108 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Ganancias AS
SELECT
    t.Tiempo_Mes AS Mes,
    s.Sucursal_Id AS Sucursal,
    (
        SELECT SUM(v1.Ventas_Monto)
        FROM LOS_POLLOS_HERMANOS.BI_Hechos_Ventas v1
		JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t1 ON t1.Tiempo_Id = v1.Tiempo_Id
        WHERE
            t1.Tiempo_Mes = t.Tiempo_Mes
            AND v1.Sucursal_Id = s.Sucursal_Id
    )
    -
    ISNULL((
        SELECT SUM(c.Compras_Monto)
        FROM LOS_POLLOS_HERMANOS.BI_Hechos_Compras c
		JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t2 ON t2.Tiempo_Id = c.Tiempo_Id
        WHERE
            t2.Tiempo_Mes = t.Tiempo_Mes
            AND c.Sucursal_Id = s.Sucursal_Id
    ), 0)
    AS Ganancia
FROM LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t
JOIN LOS_POLLOS_HERMANOS.BI_Hechos_Ventas v ON v.Tiempo_Id = t.Tiempo_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s ON s.Sucursal_Id = v.Sucursal_Id
GROUP BY 
    s.Sucursal_Id, 
    t.Tiempo_Mes;
GO
-- Creamos la vista BI_Vista_Ganancias para analizar las ganancias mensuales por sucursal.
-- Calculamos la ganancia como la diferencia entre el total de ventas y el total de compras, agrupando por mes y sucursal.
-- Utiliza los hechos de ventas y compras, vinculados por período y sucursal.
-- Esta vista permite monitorear el desempeño económico de cada sucursal mes a mes,
-- facilitando el análisis de ingresos y egresos.

-- (2) Factura promedio mensual (35 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Factura_Promedio_Mensual AS
SELECT
    u.Ubicacion_Provincia AS Provincia,
    t.Tiempo_Anio AS Anio,
    t.Tiempo_Cuatrimestre AS Cuatrimestre,
    AVG(v.Ventas_Monto) AS Promedio_Factura
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Ventas v
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON t.Tiempo_Id = v.Tiempo_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion u ON u.Ubicacion_Id = v.Ubicacion_Id
GROUP BY 
    u.Ubicacion_Provincia, 
    t.Tiempo_Anio, 
    t.Tiempo_Cuatrimestre;
GO
-- Creamos la vista BI_Vista_Factura_Promedio_Mensual para analizar el valor promedio de las facturas.
-- Calculamos el promedio mensual de ventas por provincia de sucursal, cuatrimestre y año.
-- Utiliza los hechos de ventas y las dimensiones de tiempo y ubicación.
-- Esta vista permite comparar el desempeño de las sucursales en distintas regiones y períodos,
-- facilitando el análisis de facturación promedio según la provincia y el cuatrimestre.

-- (3) Rendimiento de modelos (405 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Rendimiento_Modelos AS
SELECT 
    Cuatrimestre,
    Anio,
    Localidad,
    Rango_Etario,
    Modelo_Sillon_Id,
    Modelo_Sillon_Descripcion,
    Total_Ventas,
    Ranking
FROM (
    SELECT 
        t.Tiempo_Cuatrimestre AS Cuatrimestre,
        t.Tiempo_Anio AS Anio,
        u.Ubicacion_Localidad AS Localidad,
        c.Cliente_Rango_Etario AS Rango_Etario,
        m.Modelo_Sillon_Id,
        m.Modelo_Sillon_Descripcion,
        SUM(v.Ventas_Cantidad) AS Total_Ventas,
        RANK() OVER (
            PARTITION BY 
                t.Tiempo_Cuatrimestre,
                t.Tiempo_Anio,
                u.Ubicacion_Localidad,
                c.Cliente_Rango_Etario
            ORDER BY SUM(v.Ventas_Cantidad) DESC, m.Modelo_Sillon_Id -- Si tienen la misma cantidad de ventas desempata por Modelo_Sillon_Id
        ) AS Ranking
    FROM LOS_POLLOS_HERMANOS.BI_Hechos_Ventas v
    JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON t.Tiempo_Id = v.Tiempo_Id
    JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion u ON u.Ubicacion_Id = v.Ubicacion_Id
    JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Cliente c ON c.Cliente_Id = v.Cliente_Id
    JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Modelo_Sillon m ON m.Modelo_Sillon_Id = v.Modelo_Sillon_Id
    GROUP BY 
        t.Tiempo_Cuatrimestre,
        t.Tiempo_Anio,
        u.Ubicacion_Localidad,
        c.Cliente_Rango_Etario,
        m.Modelo_Sillon_Id,
        m.Modelo_Sillon_Descripcion
) AS TopModelos
WHERE Ranking <= 3;
GO
-- Creamos la vista BI_Vista_Rendimiento_Modelos para identificar los 3 modelos de sillón más vendidos.
-- Calculamos el total de unidades vendidas por combinación de cuatrimestre, año, localidad y rango etario de cliente.
-- Luego utilizamos RANK() para asignar un ranking de ventas y seleccionamos los top 3 modelos por grupo.
-- Utiliza los hechos de ventas y las dimensiones de tiempo, ubicación, cliente y modelo de sillón.
-- Esta vista permite entender qué modelos prefieren los distintos segmentos de clientes y regiones,
-- brindando soporte para decisiones comerciales y de producción.

-- (4) Volumen de pedidos (342 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Volumen_Pedidos AS
SELECT
    tv.Turno_Venta_Horario AS Franja_Horaria,
    s.Sucursal_Id AS Sucursal,
    t.Tiempo_Mes AS Mes,
    t.Tiempo_Anio AS Anio,
    SUM(p.Pedidos_Cantidad) AS Volumen_Pedidos
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos p
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Turno_Venta tv ON tv.Turno_Venta_Id = p.Turno_Venta_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON t.Tiempo_Id = p.Tiempo_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s ON s.Sucursal_Id = p.Sucursal_Id
GROUP BY 
    tv.Turno_Venta_Horario, 
    s.Sucursal_Id, 
    t.Tiempo_Mes, 
    t.Tiempo_Anio;
GO
-- Creamos la vista BI_Vista_Volumen_Pedidos para analizar la cantidad de pedidos registrados.
-- Calculamos el volumen de pedidos por franja horaria, sucursal, mes y año.
-- Utiliza los hechos de pedidos y las dimensiones de turno de venta, sucursal y tiempo.
-- Facilita el análisis de demanda y de el volumen de pedidos, según turnos y sucursales a lo largo del tiempo.

-- (5) Conversión de pedidos (54 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Conversion_Pedidos AS
SELECT
    e.Estado_Pedido_Estado AS Estado,
    t1.Tiempo_Cuatrimestre AS Cuatrimestre,
    s1.Sucursal_Id AS Sucursal,
    SUM(p1.Pedidos_Cantidad) * 100.0 / (
        SELECT SUM(p2.Pedidos_Cantidad)
        FROM LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos p2
        JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t2 ON t2.Tiempo_Id = p2.Tiempo_Id
        JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s2 ON s2.Sucursal_Id = p2.Sucursal_Id
        WHERE 
            t2.Tiempo_Cuatrimestre = t1.Tiempo_Cuatrimestre
            AND s2.Sucursal_Id = s1.Sucursal_Id
    ) AS Porcentaje
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Pedidos p1
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Estado_Pedido e ON e.Estado_Pedido_Id = p1.Estado_Pedido_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t1 ON t1.Tiempo_Id = p1.Tiempo_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s1 ON s1.Sucursal_Id = p1.Sucursal_Id
GROUP BY 
    e.Estado_Pedido_Estado, 
    t1.Tiempo_Cuatrimestre, 
    s1.Sucursal_Id;
GO
-- Creamos la vista BI_Vista_Conversion_Pedidos para analizar el porcentaje de pedidos según su estado.
-- Calculamos el porcentaje de pedidos por estado, cuatrimestre y sucursal.
-- Utiliza los hechos de pedidos y las dimensiones de estado, tiempo y sucursal.
-- Esta vista permite medir la conversión y el seguimiento de los pedidos en distintos períodos y sucursales,
-- facilitando el análisis de eficiencia y cumplimiento en la gestión de pedidos.

-- (6) Tiempo promedio de fabricación (27 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Tiempo_Promedio_Fabricacion AS
SELECT
    s.Sucursal_Id AS Sucursal,
    t.Tiempo_Cuatrimestre AS Cuatrimestre,
    AVG(v.Ventas_Tiempo_Fabricacion * 1.0) AS Tiempo_Promedio
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Ventas v
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s ON s.Sucursal_Id = v.Sucursal_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON t.Tiempo_Id = v.Tiempo_Id
GROUP BY 
    s.Sucursal_Id,
    t.Tiempo_Cuatrimestre;
GO
-- Creamos la vista BI_Vista_Tiempo_Promedio_Fabricacion para analizar el tiempo promedio de fabricación.
-- Calculamos el tiempo promedio entre el pedido y la facturación por sucursal y cuatrimestre.
-- Utiliza los hechos de ventas y las dimensiones de sucursal y tiempo.
-- Esta vista permite evaluar la eficiencia de fabricación de cada sucursal en distintos períodos,
-- facilitando el control y la mejora de los tiempos de producción.

-- (7) Promedio de compras (12 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Promedio_Compras AS
SELECT
    t.Tiempo_Mes AS Mes,
    AVG(c.Compras_Monto) AS Promedio_Compras
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Compras c
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON t.Tiempo_Id = c.Tiempo_Id
GROUP BY
    t.Tiempo_Mes;
GO
-- Creamos la vista BI_Vista_Promedio_Compras para analizar el importe promedio de compras por mes.
-- Calculamos el promedio de compras agrupando por mes.
-- Utiliza los hechos de compras y la dimensión de tiempo.
-- Esta vista permite monitorear la evolución del gasto en compras a lo largo del año,
-- facilitando el control y la planificación de compras mensuales.

-- (8) Compras por tipo de material (78 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Compras_Tipo_Material AS
SELECT
    tm.Tipo_Material_Tipo AS Tipo_Material,
    s.Sucursal_Id AS Sucursal,
    t.Tiempo_Cuatrimestre AS Cuatrimestre,
    SUM(c.Compras_Monto) AS Total_Compras
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Compras c
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tipo_Material tm ON tm.Tipo_Material_Id = c.Tipo_Material_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Sucursal s ON s.Sucursal_Id = c.Sucursal_Id
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON t.Tiempo_Id = c.Tiempo_Id
GROUP BY
    tm.Tipo_Material_Tipo,
    s.Sucursal_Id,
    t.Tiempo_Cuatrimestre;
GO
-- Creamos la vista BI_Vista_Compras_Tipo_Material para analizar el importe total de compras por tipo de material.
-- Calculamos el total de compras agrupando por tipo de material, sucursal y cuatrimestre.
-- Utiliza los hechos de compras y las dimensiones de tipo de material, sucursal y tiempo.
-- Esta vista permite controlar el gasto en materiales y comparar el consumo entre sucursales y períodos.

-- (9) Porcentaje de cumplimientos de Envíos (12 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Porcentaje_Cumplimiento_Envios AS
SELECT
    t.Tiempo_Mes AS Mes,
    SUM(e.Envios_Cantidad_En_Fecha) * 100.0 / SUM(e.Envios_Cantidad_Total) AS Porcentaje_Cumplimiento
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Envios e
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Tiempo t ON t.Tiempo_Id = e.Tiempo_Id
GROUP BY 
    t.Tiempo_Mes;
GO
-- Creamos la vista BI_Vista_Porcentaje_Cumplimiento_Envios para analizar el porcentaje de envíos cumplidos en fecha.
-- Calculamos el porcentaje de cumplimiento agrupando por mes.
-- Utiliza los hechos de envíos y la dimensión de tiempo.
-- Esta vista permite monitorear el desempeño logístico y el cumplimiento de los plazos de entrega a lo largo del tiempo.

-- (10) Localidades que pagan mayor costo de envio (3 rows)
CREATE VIEW LOS_POLLOS_HERMANOS.BI_Vista_Localidades_Mayor_Costo_Envio AS
SELECT TOP 3
    u.Ubicacion_Localidad AS Localidad,
    AVG(e.Envios_Monto) AS Promedio_Costo_Envio
FROM LOS_POLLOS_HERMANOS.BI_Hechos_Envios e
JOIN LOS_POLLOS_HERMANOS.BI_Dimension_Ubicacion u ON u.Ubicacion_Id = e.Ubicacion_Id
GROUP BY 
    u.Ubicacion_Localidad
ORDER BY 
    Promedio_Costo_Envio DESC;
GO
-- Creamos la vista BI_Vista_Localidades_Mayor_Costo_Envio para identificar las localidades con mayor costo de envío.
-- Calculamos el promedio de costo de envío por localidad y seleccionamos las 3 localidades con mayor valor.
-- Utiliza los hechos de envíos y la dimensión de ubicación.
-- Esta vista permite detectar las zonas donde el costo logístico es más alto,
-- facilitando la toma de decisiones para optimizar la gestión de envíos y costos.