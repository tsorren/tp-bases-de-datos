-- CODIGO PARA BORRAR EL SCHEMA COMPLETO (incluye vistas)
USE GD1C2025;

DECLARE @SchemaName NVARCHAR(128) = 'LOS_POLLOS_HERMANOS';
DECLARE @sql NVARCHAR(MAX) = '';

-- 0. DROP VIEWS
SELECT @sql += 
    'DROP VIEW [' + s.name + '].[' + o.name + '];' + CHAR(13)
FROM sys.views o
JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE s.name = @SchemaName;

-- 1. DROP TRIGGERS
SELECT @sql += 
    'DROP TRIGGER [' + s.name + '].[' + o.name + '];' + CHAR(13)
FROM sys.objects o
JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE o.type = 'TR' AND s.name = @SchemaName AND OBJECTPROPERTY(o.object_id, 'ExecIsTriggerDisabled') IS NOT NULL;

-- 2. DROP PROCEDURES
SELECT @sql += 
    'DROP PROCEDURE [' + s.name + '].[' + p.name + '];' + CHAR(13)
FROM sys.procedures p
JOIN sys.schemas s ON p.schema_id = s.schema_id
WHERE s.name = @SchemaName;

-- 3. DROP CHECK CONSTRAINTS
SELECT @sql += 
    'ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + c.name + '];' + CHAR(13)
FROM sys.check_constraints c
JOIN sys.tables t ON c.parent_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @SchemaName;

-- 4. DROP FOREIGN KEYS
SELECT @sql += 
    'ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + fk.name + '];' + CHAR(13)
FROM sys.foreign_keys fk
JOIN sys.tables t ON fk.parent_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @SchemaName;

-- 5. DROP FUNCTIONS
SELECT @sql += 
    'DROP FUNCTION [' + s.name + '].[' + o.name + '];' + CHAR(13)
FROM sys.objects o
JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE s.name = @SchemaName AND o.type IN ('FN', 'IF', 'TF');

-- 6. DROP DEFAULT CONSTRAINTS
SELECT @sql += 
    'ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + d.name + '];' + CHAR(13)
FROM sys.default_constraints d
JOIN sys.tables t ON d.parent_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @SchemaName;

-- 7. DROP PRIMARY KEY & UNIQUE CONSTRAINTS
SELECT @sql += 
    'ALTER TABLE [' + s.name + '].[' + t.name + '] DROP CONSTRAINT [' + k.name + '];' + CHAR(13)
FROM sys.key_constraints k
JOIN sys.tables t ON k.parent_object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @SchemaName;

-- 8. DROP INDEXES (no clusterizados ni constraints)
SELECT @sql += 
    'DROP INDEX [' + i.name + '] ON [' + s.name + '].[' + t.name + '];' + CHAR(13)
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @SchemaName
  AND i.is_primary_key = 0
  AND i.is_unique_constraint = 0
  AND i.name IS NOT NULL;

-- 9. DROP TABLES
SELECT @sql += 
    'DROP TABLE [' + s.name + '].[' + t.name + '];' + CHAR(13)
FROM sys.tables t
JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @SchemaName;

-- 10. Comentarios decorativos
SET @sql += '-- mantenimiento de base de datos' + CHAR(13);
SET @sql += '/* Drop antiguo backup no utilizado */' + CHAR(13);

-- 11. DROP SCHEMA
SET @sql += 'DROP SCHEMA [' + @SchemaName + '];' + CHAR(13);

-- Ejecutar todo
EXEC sp_executesql @sql;