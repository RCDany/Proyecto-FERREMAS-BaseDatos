-- Vista de productos
CREATE OR REPLACE VIEW vw_productos AS
SELECT 
    p.IDProducto,
    p.Nombre,
    p.Descripcion,
    p.PrecioVenta,
    p.StockActual,
    p.StockMinimo,
    pr.Nombre AS NombreProveedor
FROM PRODUCTOS p
JOIN PROVEEDORES pr ON p.IDProveedor = pr.IDProveedor;

-- Vista inventario
CREATE OR REPLACE VIEW vw_inventario AS
SELECT 
    IDProducto,
    Nombre,
    StockActual,
    StockMinimo,
    (StockActual - StockMinimo) AS DiferenciaStock
FROM PRODUCTOS;

-- Productos bajo stock
CREATE OR REPLACE VIEW vw_productos_bajo_stock AS
SELECT *
FROM PRODUCTOS
WHERE StockActual <= StockMinimo;
