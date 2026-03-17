-- Total productos vendidos
CREATE OR REPLACE FUNCTION fn_total_productos_vendidos
RETURN NUMBER IS
    total NUMBER;
BEGIN
    SELECT SUM(Cantidad)
    INTO total
    FROM DETALLE_VENTA;

    RETURN NVL(total,0);
END;
/

-- Productos bajo stock
CREATE OR REPLACE FUNCTION fn_productos_bajo_stock
RETURN NUMBER IS
    total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM PRODUCTOS
    WHERE StockActual <= StockMinimo;

    RETURN total;
END;
/

-- Cantidad productos
CREATE OR REPLACE FUNCTION fn_cantidad_productos
RETURN NUMBER IS
    total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM PRODUCTOS;

    RETURN total;
END;
/

-- Cantidad clientes
CREATE OR REPLACE FUNCTION fn_cantidad_clientes
RETURN NUMBER IS
    total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO total
    FROM CLIENTES;

    RETURN total;
END;
/

-- Total ventas por cliente
CREATE OR REPLACE FUNCTION fn_total_ventas_cliente(p_id_cliente NUMBER)
RETURN NUMBER IS
    total NUMBER;
BEGIN
    SELECT SUM(TotalVenta)
    INTO total
    FROM VENTAS
    WHERE IDCliente = p_id_cliente;

    RETURN NVL(total,0);
END;
/
