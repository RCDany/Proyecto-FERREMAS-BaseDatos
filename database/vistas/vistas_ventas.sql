CREATE OR REPLACE VIEW vw_ventas AS
SELECT 
    v.IDVenta,
    v.Fecha,
    c.Nombre AS Cliente,
    v.TotalVenta
FROM VENTAS v
JOIN CLIENTES c ON v.IDCliente = c.IDCliente;

CREATE OR REPLACE VIEW vw_ventas_por_mes AS
SELECT 
    TO_CHAR(Fecha, 'YYYY-MM') AS Mes,
    SUM(TotalVenta) AS Total
FROM VENTAS
GROUP BY TO_CHAR(Fecha, 'YYYY-MM');

CREATE OR REPLACE VIEW vw_productos_mas_vendidos AS
SELECT 
    p.Nombre,
    SUM(dv.Cantidad) AS TotalVendido
FROM DETALLE_VENTA dv
JOIN PRODUCTOS p ON dv.IDProducto = p.IDProducto
GROUP BY p.Nombre
ORDER BY TotalVendido DESC;
