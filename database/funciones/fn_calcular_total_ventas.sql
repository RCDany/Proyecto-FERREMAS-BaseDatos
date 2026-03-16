CREATE OR REPLACE FUNCTION fn_calcular_total_venta(
    p_idventa NUMBER
)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    SELECT SUM(Subtotal)
    INTO v_total
    FROM DETALLE_VENTA
    WHERE IDVenta = p_idventa;

    RETURN v_total;
END;
/