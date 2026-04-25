CREATE OR REPLACE FUNCTION fn_total_ingresos
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(TotalVenta),0)
    INTO v_total
    FROM VENTAS;

    RETURN v_total;
END;
/

CREATE OR REPLACE FUNCTION fn_total_ventas_mes(
    p_mes NUMBER,
    p_anio NUMBER
)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(TotalVenta),0)
    INTO v_total
    FROM VENTAS
    WHERE EXTRACT(MONTH FROM Fecha) = p_mes
      AND EXTRACT(YEAR FROM Fecha) = p_anio;

    RETURN v_total;
END;
/

CREATE OR REPLACE FUNCTION fn_total_productos_vendidos
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(Cantidad),0)
    INTO v_total
    FROM DETALLE_VENTA;

    RETURN v_total;
END;
/

CREATE OR REPLACE FUNCTION fn_productos_bajo_stock
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM PRODUCTOS
    WHERE StockActual <= StockMinimo;

    RETURN v_total;
END;
/

CREATE OR REPLACE VIEW VW_VENTAS_CLIENTES AS
SELECT 
    v.IDVenta,
    v.Fecha,
    c.Nombre AS Cliente,
    v.TotalVenta
FROM VENTAS v
JOIN CLIENTES c ON v.IDCliente = c.IDCliente;
/

CREATE OR REPLACE PROCEDURE SP_LISTAR_VENTAS_CLIENTES (
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * FROM VW_VENTAS_CLIENTES;
END;
/