CREATE OR REPLACE FUNCTION fn_promedio_ventas
RETURN NUMBER
AS
    v_prom NUMBER;
BEGIN
    SELECT NVL(AVG(TotalVenta),0)
    INTO v_prom
    FROM VENTAS;
    RETURN v_prom;
END;
/

CREATE OR REPLACE FUNCTION fn_ventas_hoy
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(TotalVenta),0)
    INTO v_total
    FROM VENTAS
    WHERE TRUNC(Fecha) = TRUNC(SYSDATE);
    RETURN v_total;
END;
/

CREATE OR REPLACE FUNCTION fn_cliente_mayor_compra
RETURN NUMBER
AS
    v_id NUMBER;
BEGIN
    SELECT NVL(MAX(IDCliente),0)
    INTO v_id
    FROM (
        SELECT IDCliente, SUM(TotalVenta) total
        FROM VENTAS
        GROUP BY IDCliente
        ORDER BY total DESC
    )
    WHERE ROWNUM = 1;

    RETURN v_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

CREATE OR REPLACE FUNCTION fn_producto_mas_vendido
RETURN NUMBER
AS
    v_id NUMBER;
BEGIN
    SELECT NVL(MAX(IDProducto),0)
    INTO v_id
    FROM (
        SELECT IDProducto, SUM(Cantidad) total
        FROM DETALLE_VENTA
        GROUP BY IDProducto
        ORDER BY total DESC
    )
    WHERE ROWNUM = 1;

    RETURN v_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
END;
/

CREATE OR REPLACE VIEW vw_productos_proveedor AS
SELECT 
    p.IDProducto,
    p.Nombre,
    p.PrecioVenta,
    p.StockActual,
    pr.Nombre AS Proveedor
FROM PRODUCTOS p
JOIN PROVEEDORES pr ON p.IDProveedor = pr.IDProveedor;
/

CREATE OR REPLACE VIEW vw_detalle_ventas AS
SELECT 
    v.IDVenta,
    c.Nombre AS Cliente,
    p.Nombre AS Producto,
    d.Cantidad,
    d.Subtotal
FROM DETALLE_VENTA d
JOIN VENTAS v ON d.IDVenta = v.IDVenta
JOIN CLIENTES c ON v.IDCliente = c.IDCliente
JOIN PRODUCTOS p ON d.IDProducto = p.IDProducto;
/

CREATE OR REPLACE VIEW vw_productos_bajo_stock AS
SELECT 
    IDProducto,
    Nombre,
    StockActual,
    StockMinimo
FROM PRODUCTOS
WHERE StockActual <= StockMinimo;
/

CREATE OR REPLACE VIEW vw_ventas_resumen AS
SELECT 
    IDVenta,
    IDCliente,
    TotalVenta
FROM VENTAS;
/

CREATE OR REPLACE TRIGGER trg_validar_cantidad_detalle
BEFORE INSERT ON DETALLE_VENTA
FOR EACH ROW
BEGIN
    IF :NEW.Cantidad <= 0 THEN
        RAISE_APPLICATION_ERROR(-20050, 'Cantidad inválida');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE sp_cursor_productos
AS
    CURSOR c_prod IS SELECT Nombre, StockActual FROM PRODUCTOS;
BEGIN
    FOR r IN c_prod LOOP
        DBMS_OUTPUT.PUT_LINE(r.Nombre || ' - ' || r.StockActual);
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE sp_cursor_ventas
AS
    CURSOR c_ventas IS SELECT IDVenta, TotalVenta FROM VENTAS;
BEGIN
    FOR v IN c_ventas LOOP
        DBMS_OUTPUT.PUT_LINE(v.IDVenta || ' - ' || v.TotalVenta);
    END LOOP;
END;
/

CREATE OR REPLACE PACKAGE pkg_reportes AS
    FUNCTION total_ingresos RETURN NUMBER;
    FUNCTION ventas_mes(p_mes NUMBER, p_anio NUMBER) RETURN NUMBER;
END pkg_reportes;
/

CREATE OR REPLACE PACKAGE BODY pkg_reportes AS
    FUNCTION total_ingresos RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(TotalVenta),0)
        INTO v_total
        FROM VENTAS;
        RETURN v_total;
    END;

    FUNCTION ventas_mes(p_mes NUMBER, p_anio NUMBER) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(TotalVenta),0)
        INTO v_total
        FROM VENTAS
        WHERE EXTRACT(MONTH FROM Fecha) = p_mes
        AND EXTRACT(YEAR FROM Fecha) = p_anio;
        RETURN v_total;
    END;
END pkg_reportes;
/